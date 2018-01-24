component {

	property name="presideObjectService" inject="PresideObjectService";

	private function index( event, rc, prc, args={} ) {

		return renderView(
			  view          = 'page-types/member_registration/index'
			, presideObject = 'member_registration'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}


	public function submit( event, rc, prc, args={} ) {

		var formName   = "custom-forms.event_booking";
		var formData   = event.getCollectionForForm( formName );
		var validation = validateForm( formName, formData );
		var alertClass = "";
		var formSuccess = "";
		var hasError = false;


		if( validation.validated() ){

			formSuccess = _saveEventBooking(formData, rc.price);


			if( !isEmptyString(formSuccess) ) {
				alertClass = "alert-success";
				validation.setGeneralMessage( translateResource( "forms:alert.form_success" ) );
			}
			else {
				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error_submission" ) );
			}
		}
		else {
			alertClass = "alert-danger";
			validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

		}

		setNextEvent(
			  url           = event.buildLink( page="event_booking_page", queryString="ev="&rc.slug )
			, persistStruct = {
					  alertClass       = alertClass
					, alertMessage     = validation.getGeneralMessage()
					, savedData        = formData
					, validationResult = validation
					, formSuccess      = formSuccess
			}
		);
	}


	public any function _saveEventBooking(required struct formData, required numeric price) {

		var total_amount      = price * formData.number_seats;

		return presideObjectService.insertData(
	          objectName = "event_booking"
	        , data       = { 
	        	  event_detail    = formData.event_detail
	        	, firstname       = formData.firstname
	        	, lastname        = formData.lastname
	        	, email_address   = formData.email
	        	, number_seats    = formData.number_seats
	        	, total_amount    = total_amount
	        	, sessions        = formData.session
	        	, special_request = formData.special_request
	        }
		);
	}
}