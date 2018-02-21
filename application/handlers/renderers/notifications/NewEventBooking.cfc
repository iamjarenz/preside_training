component {
	private string function datatable( event, rc, prc, args={} ) {
		// args.eventDetails = args.event_details.event_detail;
		// args.bookingDetails = args.booking_details.booking_detail;


		args.eventDetails = _reorderEventData( args=args );
		args.bookingDetails = _reorderBookingData( args=args );
		
		return renderView(
			   view = "/renderers/notifications/newEventBooking/dataTable"
			 , args = args
		);
	}

	private string function full( event, rc, prc, args={} ) {

		args.eventDetails = _reorderEventData( args=args );
		args.bookingDetails = _reorderBookingData( args=args );

		return renderView(
			   view = "/renderers/notifications/newEventBooking/full"
			 , args = args
		);
	}

	private string function emailSubject( event, rc, prc, args={} ) {
		return "New event booking";
	}

	private string function emailHtml( event, rc, prc, args={} ) {

		var data = deserializeJSON( args.data ?: "" )
		args.eventDetails = _reorderEventData( args=data );
		args.bookingDetails = _reorderBookingData( args=data );

		return renderView(
			  view = "/renderers/notifications/newEventBooking/emailHtml"
			, args = args
		);
	}

	private string function emailText( event, rc, prc, args={} ) {

		var data = deserializeJSON( args.data ?: "" )
		args.eventDetails = _reorderEventData( args=data );
		args.bookingDetails = _reorderBookingData( args=data );
		
		return renderView(
			  view = "/renderers/notifications/newEventBooking/emailText"
			, args = args
		);
	}


	public struct function _reorderEventData(  args={} ) {

		var eventDataOrdered = structNew( "ordered" );

		eventDataOrdered.event_title = args.event_details.event_detail.title                   ?: "";
		eventDataOrdered.start_date  = dateFormat( args.event_details.event_detail.start_date  ?: "", "dd-mmm-yyyy" );
		eventDataOrdered.end_date    = dateFormat( args.event_details.event_detail.end_date    ?: "", "dd-mmm-yyyy" );
		eventDataOrdered.region      = replace( args.event_details.event_detail.region         ?: "", ",", ", ", "all" );
		eventDataOrdered.category    = replace( args.event_details.event_detail.category       ?: "", ",", ", ", "all" );
		eventDataOrdered.price    = args.event_details.event_detail.price                   ?: "";

		return eventDataOrdered;
	}
	public struct function _reorderBookingData(  args={} ) {

		var bookingDataOrdered = structNew( "ordered" );

		bookingDataOrdered.firstname       = args.booking_details.booking_detail.firstname ?: "";
		bookingDataOrdered.lastname        = args.booking_details.booking_detail.lastname  ?: "";
		bookingDataOrdered.email_address   = args.booking_details.booking_detail.email     ?: "";
		bookingDataOrdered.number_seats    = args.booking_details.booking_detail.number_seats    ?: "";
		bookingDataOrdered.total_amount    = args.booking_details.booking_detail.total_amount    ?: "";
		bookingDataOrdered.sessions        = replace( args.booking_details.booking_detail.sessions        ?: "", ",", ", ", "all" );
		bookingDataOrdered.special_request = args.booking_details.booking_detail.special_request ?: "";

		return bookingDataOrdered;
	}


}