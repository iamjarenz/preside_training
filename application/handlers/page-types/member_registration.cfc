component {

	property name="userService" inject="UserService";

	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();

		return renderView(
			  view          = 'page-types/member_registration/index'
			, presideObject = 'member_registration'
			, id            = pageId
			, args          = args
		);
	}


	public function submit( event, rc, prc, args={} ) {

		var formName   = "registration.user_details";
		var formData   = event.getCollectionForForm( formName );
		var validation = validateForm( formName, formData );
		var alertClass = "";
		var websiteUser = "";
		var userDetail = "";
		var userInterests = "";
		var memberDetail = {};
		var hasError = false;


		if( validation.validated() ){

			var validConfirmPassword = userService.isValidConfirmPassword(
				  newPassword     = formData.password
				, confirmPassword = formData.password_confirm
			);

			var invalidEmail = userService.isExistingEmail(
				email = formData.email
			);
			var invalidUserId = userService.isExistingUserId(
				user_id = formData.user_id
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
				userDetail  = userService.saveWebsiteUserDetails(
					  firstname = formData.firstname
					, lastname  = formData.lastname
					, dob       = formData.dob
					, address   = formData.address
					, gender    = formData.gender
				);
				

				if( !isEmptyString(userDetail) ) {
					websiteUser = userService.saveWebsiteUser(
			        	  login_id      = formData.user_id
			        	, email_address = formData.email
			        	, password      = formData.password
			        	, firstname     = formData.firstname
						, lastname      = formData.lastname
			        	, user_detail   = userDetail
					);


					if( !isEmptyString(websiteUser) && !isEmptyString(userDetail) && !isEmptyString(formData.interested_in) ) {

						userService.saveWebsiteUserInterest(
							  interests = listToArray(formData.interested_in) 
							, user_id   = userDetail
						);

						userInterests = userService.getUserInterests(userDetail);
					}

					memberDetail = {
						personal = {
							  firstname = formData.firstname
							, lastname  = formData.lastname
							, email     = formData.email
							, gender    = formData.gender
							, dob       = formData.dob
							, address   = formData.address
						}
						, interests   = ValueList(userInterests.label) ?: ""
					};



					userService.sendMemberConfirmationEmail(
						  email_address  = formData.email
						, firstname      = formData.firstname
						, lastname       = formData.lastname
						, member_details = memberDetail
						, login_id       = formData.user_id
					);

					alertClass = "alert-success";
					validation.setGeneralMessage( translateResource( "forms:alert.form_success_registration" ) );
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
			}
		);
	}



}
