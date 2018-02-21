component {

	property name="eventBookingService"  inject="EventBookingService";
	property name="eventService"  inject="EventService";
	property name="websiteLoginService" inject="WebsiteLoginService";
	property name="userService" inject="UserService";


	public void function preHandler( event, action, eventArguments ) {

		var event_slug = rc.ev ?: "";


		args.event_detail = eventService.getEventBySlug( event_slug );
		prc.bookable    = args.event_detail.bookable;

		if( ! args.event_detail.recordCount ) {
			event.notFound();
		} 
		else {

			if ( ! args.event_detail.bookable ) {
				event.notFound();
			}


			prc.event_slug      = rc.ev;
			prc.event_id        = args.event_detail.id;
			prc.event_detail    = args.event_detail;
			prc.available_seats = args.event_detail.available_seats;
			prc.booked_seats    = args.event_detail.booked_seats;


			if ( isLoggedIn() ) {
				prc.user_details = websiteLoginService.getLoggedInUserDetails();
				var websiteUser  =  userService.getWebsiteUserById( prc.user_details.id );
				prc.web_user = websiteUser;

				if( isNull( rc.savedData.firstname ) ) {
					rc.savedData.firstname = websiteUser.firstname ?: "";
				}
				if( isNull( rc.savedData.lastname ) ) {
					rc.savedData.lastname = websiteUser.lastname ?: "";
				}
				if( isNull( rc.savedData.email ) ) {
					rc.savedData.email = websiteUser.email_address ?: "";
					prc.email = websiteUser.email_address ?: "";
				}
			}
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
		var hasError = false;


		if( validation.validated() ){

			if( !isValid( "email", formData.email ) ){
				hasError = true;

				alertClass = "alert-danger";
				validation.setGeneralMessage( translateResource( "forms:alert.form_error" ) );

				validation.addError( fieldName="email", message=translateResource( "forms:alert.email_invalid" ) );
			}

			if( !hasError ) {

				transaction {
					eventBooked = eventBookingService.saveBookingDetails(
						  event_detail    = prc.event_id
						, firstname       = stripHTML(formData.firstname)
						, lastname        = stripHTML(formData.lastname)
						, email_address   = stripHTML(formData.email)
						, number_seats    = formData.number_seats
						, price           = prc.event_detail.price
						, special_request = stripHTML(formData.special_request)
						, sessions        = formData.session
					);


					if( !isEmptyString(eventBooked) ) {


						// send event booking email
						args.formData    = formData;
						args.eventBooked = eventBooked;
						_sendEventBookingConfirmationEmail( argumentCollection = arguments );


						alertClass = "alert-success";
						validation.setGeneralMessage( translateResource( "forms:alert.form_success_eventbooking" ) );
					}
				}

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
					, success          = !isEmptyString(eventBooked)
			}
		);
	}

// PRIVATE
	private void function _sendEventBookingConfirmationEmail( event, rc, prc, args={} ) {

		// build event detail data struct
		var eventDetail = {
			event_detail = {
				  title      = prc.event_detail.title
				, start_date = prc.event_detail.start_date
				, end_date   = prc.event_detail.end_date
				, price      = prc.event_detail.price
				, category   = prc.event_detail.category_label
			}
		};

		// get event regions
		var eventRegions = eventService.getEventRegions(eventDetailId=prc.event_id);
		// add regions to event detail struct
		eventDetail.event_detail.region = eventRegions.recordCount ? ValueList(eventRegions.label) : "";

		// build event booking data struct
		var bookingDetail =  {
			booking_detail = {
				  firstname       = args.formData.firstname
				, lastname        = args.formData.lastname
				, email           = args.formData.email
				, number_seats    = args.formData.number_seats
				, total_amount    = args.formData.number_seats * prc.event_detail.price
				, special_request = args.formData.special_request
			}
		};
		
		// get booking session
		var eventSessions =  eventBookingService.getBookingSessions(event_booking=args.eventBooked);
		// add session to event detail struct
		bookingDetail.booking_detail.sessions = eventSessions.recordCount ? ValueList(eventSessions.label) : "";

		// send confirmation email
		eventBookingService.sendEventBookingConfirmationEmail(
			  email_address   = args.formData.email
			, firstname       = args.formData.firstname
			, lastname        = args.formData.lastname
			, event_details   = eventDetail
			, booking_details = bookingDetail
		);


		// update booked seats
		eventBookingService.saveBookedSeats(
			  event_id        = prc.event_id
			, event_details   = eventDetail
			, number_seats    = args.formData.number_seats
			, booked_seats    = prc.booked_seats
			, available_seats = prc.available_seats
		);
	}

}
