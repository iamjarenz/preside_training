component {

	property name="userService" inject="UserService";



	public void function preHandler( event, action, eventArguments ) {

		if ( isLoggedIn() ) {
			event.notFound();
		}

	}


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
		var hasError = false;


		if( validation.validated() ){

			var validConfirmPassword = userService.isValidConfirmPassword(
				  newPassword     = formData.password
				, confirmPassword = formData.password_confirm
			);

			var invalidEmail = userService.isExistingEmail( email = formData.email );
			var invalidUserId = userService.isExistingUserId(
				user_id = formData.user_id
			);

			if( !validConfirmPassword ){
				hasError = true;
				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="password_confirm", message=translateResource( "forms:alert.confirm_password_not_match" ) );
			}
			if( !isValid( "email", formData.email ) ){
				hasError = true;

				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="email", message=translateResource( "forms:alert.email_invalid" ) );
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
				transaction {
					userDetail  = userService.saveWebsiteUserDetails(
						  firstname = formData.firstname
						, lastname  = formData.lastname
						, dob       = formData.dob
						, address   = formData.address
						, country   = formData.country
						, gender    = formData.gender
						, interests = formData.interested_in
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

						// send email confirmation
						args.userDetail = userDetail;
						args.formData = formData;
						_sendMemberConfirmationEmail( argumentCollection = arguments );

						alertClass = "alert-success";
						validation.setGeneralMessage( translateResource( "forms:alert.form_success_registration" ) );
					}
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
					, success          = !isEmptyString(websiteUser) && !isEmptyString(userDetail)
			}
		);
	}


// PRIVATE
	private void function _sendMemberConfirmationEmail( event, rc, prc, args={} ) {

		var userInterests = userService.getUserInterests( arguments.args.userDetail );

		var memberDetail = {
			personal = {
				  firstname = args.formData.firstname
				, lastname  = args.formData.lastname
				, email     = args.formData.email
				, gender    = args.formData.gender
				, dob       = args.formData.dob
				, country   = args.formData.country
				, address   = args.formData.address
			}
			, interests   = userInterests.recordCount ? ValueList(userInterests.label) : ""
		};


		userService.sendMemberConfirmationEmail(
			  email_address  = args.formData.email
			, firstname      = args.formData.firstname
			, lastname       = args.formData.lastname
			, member_details = memberDetail
			, login_id       = args.formData.user_id
		);
	}


}
