/**
 * @presideService
 */
component {

// constructor
	/**
	 * @bcryptService.inject              bcryptService
	 * @notificationService.inject        notificationService
	 */
	public any function init(
		  required any bcryptService
		, required any notificationService
	) {
		_setBCryptService( arguments.bcryptService );
		_setNotificationService( arguments.notificationService );

		return this;
	}


	public boolean function isValidConfirmPassword( required string newPassword, required string confirmPassword ) {
		return arguments.newPassword == arguments.confirmPassword;
	}

	public boolean function isExistingEmail( required string email ) {
		var email_exist = $getPresideObjectService().dataExists(
			  objectName = "website_user"
			, filter     = { email_address = email }
		);
		// returns true if exists
		return email_exist;
	}

	public boolean function isExistingUserId( required string user_id ) {
		var user_id_exist = $getPresideObjectService().dataExists(
			  objectName = "website_user"
			, filter     = { login_id = user_id }
		);
		// returns true if exists
		return user_id_exist;
	}

	public any function saveWebsiteUser(
		  required string login_id
		, required string email_address
		, required string password
		, required string firstname
		, required string lastname
		, required string user_detail
	) {

		var display_name      = arguments.firstname & " " & arguments.lastname;
		var encryptedPassword = _getBCryptService().hashPw( arguments.password );

		return  $getPresideObjectService().insertData(
			  objectName = "website_user"
			, data       = { 
				  login_id      = arguments.login_id
				, email_address = arguments.email_address
				, password      = encryptedPassword
				, display_name  = display_name
				, active        = 1
				, user_detail   = arguments.user_detail
			}
		);
	}
	public any function saveWebsiteUserDetails(
		  required string firstname
		, required string lastname
		, required string dob
		, string address = ""
		, string gender  = ""
	) {

		return  $getPresideObjectService().insertData(
			  objectName = "user_detail"
			, data       = { 
				  firstname     = arguments.firstname
				, lastname      = arguments.lastname
				, dob           = dateFormat(arguments.dob, "yyyy-mm-dd" )
				, address       = arguments.address
				, gender        = arguments.gender
			}
		);
	}

	public void function saveWebsiteUserInterest(
		  required array interests
		, required string user_id
	) {

		for (interest in interests) {
			$getPresideObjectService().insertData(
				  objectName = "user_interests"
				, data       = { 
					  user_detail   = user_id
					, category      = interest
				}
			);
		}

	}

	public query function getUserInterests( required string user_detail ) {

		return $getPresideObjectService().selectData(
			  objectName = "user_interests"
			, selectFields = [ "category.label" ]
			, filter = { "user_detail" = arguments.user_detail }
			, orderBy      = "category.label ASC"
		);
	}

	public query function getWebsiteUserById( required string user_id ) {

		return $getPresideObjectService().selectData(
			  objectName = "website_user"
			, id = user_id
			, selectFields = [ 
				  "login_id" 
				, "email_address"
				, "display_name"
			]
		);
	}

	public boolean function updateWebsiteUserEmail(
		  required string user_id
		, required string email_address
	) {
		var updated = $getPresideObjectService().updateData(
			  objectName = "website_user"
			, id         = user_id
			, data       = { email_address = arguments.email_address }
		);

		return updated > 0;

	}

	public void function sendMemberConfirmationEmail(
		  required string email_address
		, required string firstname
		, required string lastname
		, required struct member_details
		, required string login_id
	) {

		var display_name      = arguments.firstname & " " & arguments.lastname;

		// Emails
		$sendEmail(
			  template = "MemberConfirmation"
			, to       = [ arguments.email_address ]
			, args     = {
				  member_details  = arguments.member_details
				, display_name    = display_name
				, login_id        = arguments.login_id
			}
		);


		// add login_id to details
		member_details.login_id = arguments.login_id;
		// send notification
		_getNotificationService().createNotification(
			  topic = "newMemberRegistration"
			, type  = "info"
			, data  = { member_details=arguments.member_details }
		);
	}


// private accessors
	private any function _getBCryptService() {
		return _bCryptService;
	}
	private void function _setBCryptService( required any bCryptService ) {
		_bCryptService = arguments.bCryptService;
	}
	private any function _getNotificationService()  {
		return _notificationService;
	}
	private void function _setNotificationService( required any notificationService )  {
		_notificationService = arguments.notificationService;
	}


}