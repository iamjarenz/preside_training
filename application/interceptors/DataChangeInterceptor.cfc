component extends="coldbox.system.Interceptor" {

	property name="notificationService"  inject="delayedInjector:notificationService";
	property name="userService"  inject="delayedInjector:userService";
	property name="eventService"  inject="delayedInjector:eventService";

// PUBLIC
	public void function configure() {}


	public void function preUpdateObjectData( required any event, required struct interceptData ) output=false {
		var objectName     = arguments.interceptData.objectName ?: "";
		var id             = arguments.interceptData.id         ?: "";
		var data           = arguments.interceptData.data       ?: {};


		switch( objectName ){
			case "website_user": {

				var websiteUser = userService.getWebsiteUserById(id);
				if( websiteUser.recordCount ) {
					arguments.interceptData.websiteUser.login_id      = websiteUser.login_id;
					arguments.interceptData.websiteUser.display_name  = websiteUser.display_name;
					arguments.interceptData.websiteUser.email_address = websiteUser.email_address;
				}

				break;
			}


		}

	}
	public void function postUpdateObjectData( required any event, required struct interceptData ) output=false {
		var objectName     = arguments.interceptData.objectName  ?: "";
		var id             = arguments.interceptData.id          ?: "";
		var data           = arguments.interceptData.data        ?: {};

		switch( objectName ){
			case "website_user": {
				var websiteUser = arguments.interceptData.websiteUser ?: {};

				if ( data.keyExists( "email_address" ) && ( data.email_address != websiteUser.email_address ) ) {
					var userData    = structNew('ordered');

					userData.login_id      = websiteUser.login_id;
					userData.display_name  = websiteUser.display_name;
					userData.email_address = data.email_address;

					notificationService.createNotification(
						  topic = "updateMemberDetails"
						, type  = "info"
						, data  = { userData=userData }
					);

				}
				break;
			}


			case "event_detail": {
				var slug = eventService.getEventSlugById(id).slug;
				var eventDetail = eventService.getEventBySlug(slug);

				if( data.keyExists( "booked_seats" ) && eventDetail.recordCount ) {

					var eventData = structNew( "ordered" );

					eventData.title     = eventDetail.title                 ?: "";          
					eventData.available_seats = eventDetail.available_seats ?: 0;
					eventData.booked_seats    = data.booked_seats           ?: 0;


					if( eventData.available_seats == data.booked_seats && eventData.available_seats != 0 ) {
						// send notification if fully booked
						notificationService.createNotification(
							  topic = "eventFullyBooked"
							, type  = "alert"
							, data  = { 
								  event_details = eventData
							}
						);
					}

				}

				break;
			}

		}
	}

}