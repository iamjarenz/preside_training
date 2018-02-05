component {
	private struct function prepareParameters( required struct event_details, required struct booking_details, required string display_name ) {


		return {
			  display_name = arguments.display_name
			, event_details   = {
				  html = trim( renderView( view = "/email/template/eventBooking/_eventDetailsHtml", args = event_details ) )
				, text = trim( renderView( view = "/email/template/eventBooking/_eventDetailsText", args = event_details ) )
			}
			, booking_details   = {
				  html = trim( renderView( view = "/email/template/eventBooking/_bookingDetailsHtml", args = booking_details ) )
				, text = trim( renderView( view = "/email/template/eventBooking/_bookingDetailsText", args = booking_details ) )
			}
		};
	}

	private struct function getPreviewParameters() {

		return {
			  display_name = "John Smith"
			, event_details   = {
				  html = trim( renderView( view = "/email/template/eventBooking/_eventDetailsHtml", args = _getPreviewEventDetails() ) )
				, text = trim( renderView( view = "/email/template/eventBooking/_eventDetailsText", args = _getPreviewEventDetails() ) )
			}
			, booking_details   = {
				  html = trim( renderView( view = "/email/template/eventBooking/_bookingDetailsHtml", args = _getPreviewBookingDetails() ) )
				, text = trim( renderView( view = "/email/template/eventBooking/_bookingDetailsText", args = _getPreviewBookingDetails() ) )
			}
		};
	}



	private struct function _getPreviewEventDetails(){
		return {
			event_detail = {
				  title      = "Cordillera Mountain Ultra"
				, start_date = dateAdd( "d", -40, now() )
				, end_date   = dateAdd( "d", -30, now() )
				, category   = "Outdoor,Mountains"
				, region     = "Cordillera"
				, price      = 1000
			}
		};
	}
	private struct function _getPreviewBookingDetails(){
		return {
			booking_detail = {
				  firstname       = "John"
				, lastname        = "Smith"
				, email           = "john@smith.com"
				, number_seats    = 5
				, total_amount    = 5000
				, sessions        = "Session 1,Session 4,Session 8"
				, special_request = "I'm allergic to seafood."
			}
		};
	}


	private string function defaultSubject() {
		return "Event Booking Confirmation";
	}

	private string function defaultHtmlBody() {
		return renderView( view="/email/template/eventBooking/defaultHtmlBody" );
	}

	private string function defaultTextBody() {
		return renderView( view="/email/template/eventBooking/defaultTextBody" );
	}

}