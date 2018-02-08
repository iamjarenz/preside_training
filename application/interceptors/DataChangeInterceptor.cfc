component extends="coldbox.system.Interceptor" {

	property name="notificationService"  inject="delayedInjector:notificationService";
	property name="userService"  inject="delayedInjector:userService";

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

		}
	}

// PRIVATE
	private struct function _queryRowToStruct(
		  required query   qry
		,          numeric row = 1
	) {
		var strct = StructNew();
		var cols  = ListToArray( arguments.qry.columnList );
		var col   = "";

		for( col in cols ){
			strct[col] = arguments.qry[col][arguments.row];
		}

		return strct;

	}
}