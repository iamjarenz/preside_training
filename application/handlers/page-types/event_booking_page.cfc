component {

	property name="eventBookingService"  inject="EventBookingService";
	property name="eventService"  inject="EventService";

	public void function preHandler( event, action, eventArguments ) {

		var event_slug = rc.ev ?: "";


		args.event_detail = eventService.getEventBySlug( event_slug );

		if( ! args.event_detail.recordCount ) {
			event.notFound();
		} 
		else {
			prc.event_slug = rc.ev;
			prc.event_id = args.event_detail.id;
			prc.event_detail = args.event_detail
		}


	}

	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();

		args.event_detail = prc.event_detail;
		args.session = eventService.getEventSessions(prc.event_id);

		return renderView(
			  view          = 'page-types/event_booking_page/index'
			, presideObject = 'event_booking_page'
			, id            = pageId
			, args          = args
		);
	}


	public function submit( event, rc, prc, args={} ) {

		var formName   = "event-booking.booking_details";
		var formData   = event.getCollectionForForm( formName );
		var validation = validateForm( formName, formData );
		var alertClass = "";
		var eventBooked = "";
		var eventSessions = "";
		var hasError = false;


		if( validation.validated() ){

			eventBooked = eventBookingService.saveBookingDetails(
				  event_detail    = prc.event_id
				, firstname       = formData.firstname
				, lastname        = formData.lastname
				, email_address   = formData.email
				, number_seats    = formData.number_seats
				, price           = prc.event_detail.price
				, special_request = formData.special_request
			);


			if( !isEmptyString(eventBooked) ) {
				if( !isEmptyString(formData.session) ) {
					eventSessions = eventBookingService.saveBookingSessions(
						  event_booking = eventBooked
						, sessions      = listToArray(formData.session) 
					);
				}
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
			  url           = event.buildLink( page="event_booking_page", queryString="ev="&prc.event_slug )
			, persistStruct = {
					  alertClass       = alertClass
					, alertMessage     = validation.getGeneralMessage()
					, savedData        = formData
					, validationResult = validation
			}
		);
	}


}
