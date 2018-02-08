component {

	property name="websiteLoginService" inject="WebsiteLoginService";
	property name="userService" inject="UserService";


	public void function preHandler( event, action, eventArguments ) {

		if ( !isLoggedIn() || isAutoLoggedIn() ) {
			event.accessDenied( reason="LOGIN_REQUIRED" );
		}


		prc.user_details = websiteLoginService.getLoggedInUserDetails();
		var websiteUser = queryRowToStruct( userService.getWebsiteUserById( prc.user_details.id ) );

		if( isNull( rc.savedData.login_id ) ) {
			rc.savedData.login_id = websiteUser.login_id ?: "";
		}
		if( isNull( rc.savedData.display_name ) ) {
			rc.savedData.display_name = websiteUser.display_name ?: "";
		}
		if( isNull( rc.savedData.email_address ) ) {
			rc.savedData.email_address = websiteUser.email_address ?: "";
			prc.current_email_address = websiteUser.email_address ?: "";
		}
	}

	private function index( event, rc, prc, args={} ) {


		return renderView(
			  view          = 'page-types/update_details_page/index'
			, presideObject = 'update_details_page'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function submit( event, rc, prc, args={} ) {

		var formName   = "registration.update_email";
		var formData   = event.getCollectionForForm( formName );
		var validation = validateForm( formName, formData );
		var alertClass = "";
		var updated = false;
		var hasError = false;


		if( validation.validated() ){

			var invalidEmail = userService.isExistingEmail( email = formData.email_address );

			if( prc.current_email_address != formData.email_address ) {
				if( !isValid( "email", formData.email_address ) ){
					hasError = true;

					alertClass = "alert-danger";
					validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

					validation.addError( fieldName="email_address", message=translateResource( "forms:alert.email_invalid" ) );
				}
				if( invalidEmail ){
					hasError = true;

					alertClass = "alert-danger";
					validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

					validation.addError( fieldName="email_address", message=translateResource( "forms:alert.email_already_exists" ) );
				}
			}
			if( !hasError ) {
				transaction {
					updated = userService.updateWebsiteUserEmail(
						  user_id       = prc.user_details.id
						, email_address = formData.email_address
					);


					if( updated ) {
						prc.current_email_address = formData.email_address;

						alertClass = "alert-success";
						validation.setGeneralMessage( translateResource( "forms:alert.form_success_update" ) );
					}
				}

			}

		}

		else {

			alertClass = "alert-danger";
			validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

		}

		setNextEvent(
			  url           = event.buildLink( page="update_details_page" )
			, persistStruct = {
					  alertClass       = alertClass
					, alertMessage     = validation.getGeneralMessage()
					, savedData        = formData
					, validationResult = validation
					, success          = updated
			}
		);
	}
}
