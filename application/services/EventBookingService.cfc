/**
 * @presideService
 */
component {

// constructor
	/**
	 * @EventService.inject              EventService
	 * @notificationService.inject        notificationService
	 */
    public any function init(
		  required any EventService
		, required any notificationService
    ) {
		_setEventService( arguments.EventService );
		_setNotificationService( arguments.notificationService );

        return this;
    }


	public any function saveBookingDetails(
		  required string event_detail
		, required string firstname
		, required string lastname
		, required string email_address
		, required numeric number_seats
		, required numeric price
		,          string special_request = ""
		,          string sessions        = ""
	) {

		var total_amount      = arguments.price * arguments.number_seats;

		return $getPresideObjectService().insertData(
	          objectName = "event_booking"
	        , data       = { 
	        	  event_detail    = arguments.event_detail
	        	, firstname       = arguments.firstname
	        	, lastname        = arguments.lastname
	        	, email_address   = arguments.email_address
	        	, number_seats    = arguments.number_seats
	        	, total_amount    = total_amount
	        	, special_request = arguments.special_request
	        	, sessions        = arguments.sessions
	        }
			, insertManyToManyRecords  = true
		);
	}

	public boolean function saveBookedSeats( 
		  required string  event_id
		, required struct  event_details
		, required numeric number_seats 
		, required numeric booked_seats 
		, required numeric available_seats 
	) {
		var booked = number_seats + booked_seats;
		event_details.event_detail.booked_seats    = booked;
		event_details.event_detail.available_seats = available_seats;

		transaction {

			var updated = $getPresideObjectService().updateData(
				  objectName = "event_detail"
				, id         = event_id
				, data       = { booked_seats = booked }
			);

			return updated > 0;

		}

	}


    public query function getBookingSessions( required string event_booking ) {

    	return  $getPresideObjectService().selectData(
			  selectFields = [ "session.label" ]
			, objectName = "event_booking_sessions"
			, filter     = { "event_booking" = arguments.event_booking }
			, orderBy    = "session.label ASC"
		);
    }


	public void function sendEventBookingConfirmationEmail(
		  required string email_address
		, required string firstname
		, required string lastname
		, required struct event_details
		, required struct booking_details
	) {

		var display_name      = arguments.firstname & " " & arguments.lastname;

		// Emails
		$sendEmail(
			  template = "EventBooking"
			, to       = [ arguments.email_address ]
			, args     = {
				  event_details   = arguments.event_details
				, booking_details = arguments.booking_details
				, display_name    = display_name
			}
		);


		// send notification
		_getNotificationService().createNotification(
			  topic = "newEventBooking"
			, type  = "info"
			, data  = { 
				  event_details   = arguments.event_details
				, booking_details = arguments.booking_details
			}
		);
	}

// private accessors
	private any function _getEventService() {
		return _EventService;
	}
	private void function _setEventService( required any EventService ) {
		_EventService = arguments.EventService;
	}
	private any function _getNotificationService()  {
		return _notificationService;
	}
	private void function _setNotificationService( required any notificationService )  {
		_notificationService = arguments.notificationService;
	}
}