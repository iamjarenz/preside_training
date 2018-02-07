component extends="coldbox.system.Interceptor" {

	property name="notificationService"  inject="delayedInjector:notificationService";

// PUBLIC
	public void function configure() {}


	public void function postUpdateObjectData( required any event, required struct interceptData ) {
		var objectName     = arguments.interceptData.objectName ?: "";
		var id             = arguments.interceptData.id         ?: "";
		var interceptData  = arguments.interceptData.data       ?: {};

		switch( objectName ){
			case "website_user": {
				if ( interceptData.keyExists( "email_address" ) ) {

					notificationService.createNotification(
						  topic = "updateMemberDetails"
						, type  = "info"
						, data  = { interceptData=interceptData }
					);

				}
				break;
			}

		}
	}
}