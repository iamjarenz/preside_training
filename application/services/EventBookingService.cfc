/**
 * @presideService
 */
component {

// constructor
	/**
	 * @EventService.inject              EventService
	 */
    public any function init(
		required any EventService
    ) {
		_setEventService( arguments.EventService );

        return this;
    }


	public any function saveBookingDetails(
		  required string event_detail
		, required string firstname
		, required string lastname
		, required string email_address
		, required numeric number_seats
		, required numeric price
		, string special_request = ""
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
	        }
		);
	}


	public void function saveBookingSessions(
		  required string event_booking
		, required array sessions
	) {
		var ctr = 1;
		for (session_item in sessions) {
			$getPresideObjectService().insertData(
				  objectName = "event_booking_sessions"
				, data       = { 
					  event_booking = event_booking
					, session       = session_item
					, sort_order    = ctr
				}
			);
			ctr++;
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
				  event_details  = arguments.event_details
				, booking_details  = arguments.booking_details
				, display_name    = display_name
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
}