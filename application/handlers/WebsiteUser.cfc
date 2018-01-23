component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="getBCryptService" inject="BCryptService";

	private function index( event, rc, prc, args={} ) {

		return renderView(
			  view          = 'page-types/member_registration/index'
			, presideObject = 'member_registration'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}


	public function submitRegistration( event, rc, prc, args={} ) {

		var formName   = "custom-forms.registration";
		var formData   = event.getCollectionForForm( formName );
		var validation = validateForm( formName, formData );
		var alertClass = "";
		var formSuccess = "";
		var hasError = false;


		if( validation.validated() ){

			var validConfirmPassword = _validConfirmPassword(
				  newPassword     = formData.password
				, confirmPassword = formData.password_confirm
			);

			var invalidEmail = _validEmail(
				  email = formData.email
			);
			var invalidUserId = _validUserId(
				  email = formData.email
				, user_id = formData.user_id
			);

			if( !validConfirmPassword ){
				hasError = true;
				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="password_confirm", message=translateResource( "forms:alert.confirm_password_not_match" ) );
			}
			if( invalidEmail ){
				hasError = true;

				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="email", message=translateResource( "forms:alert.email_already_exists" ) );
			}
			if( invalidUserId ){
				hasError = true;

				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="user_id", message=translateResource( "forms:alert.user_id_already_exists" ) );
			}
			if( !hasError ) {
				formSuccess = _saveWebsiteUser(formData);

				if( !isEmptyString(formSuccess) ) {
					alertClass = "alert-success";
					validation.setGeneralMessage( translateResource( "forms:alert.form_success" ) );
				}
				else {
					alertClass = "alert-danger";
					validation.setGeneralMessage( translateResource( "forms:alert.form_error_submission" ) );
				}
			}

		}

		else {

			alertClass = "alert-danger";
			validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

		}

		setNextEvent(
			  url           = event.buildLink( page="member_registration" )
			, persistStruct = {
					  alertClass       = alertClass
					, alertMessage     = validation.getGeneralMessage()
					, savedData        = formData
					, validationResult = validation
					, formSuccess      = formSuccess
			}
		);
	}


	private boolean function _validConfirmPassword( required string newPassword, required string confirmPassword ) {
		return arguments.newPassword == arguments.confirmPassword;
	}

	private boolean function _validEmail( required string email ) {
		var emailExist = presideObjectService.dataExists(
		      objectName = "website_user"
		    , filter     = { email_address = email }
		);
		// returns true if exists
		return emailExist;
	}

	private boolean function _validUserId( required string user_id ) {
		var user_id = presideObjectService.dataExists(
		      objectName = "website_user"
		    , filter     = { login_id = user_id }
		);
		// returns true if exists
		return user_id;
	}

	public any function _saveWebsiteUser(required struct formData) {

		var display_name      = formData.firstname & " " & formData.lastname;
		var encryptedPassword = getBCryptService.hashPw( formData.password );

		return presideObjectService.insertData(
	          objectName = "website_user"
	        , data       = { 
	        	  login_id      = formData.user_id
	        	, email_address = formData.email
	        	, password      = encryptedPassword
	        	, display_name  = display_name
	        	, active        = 1
	        	, dob           = formData.dob
	        	, address       = formData.address
	        	, gender        = formData.gender
	        	, interested_in = formData.interested_in
	        }
		);
	}
}