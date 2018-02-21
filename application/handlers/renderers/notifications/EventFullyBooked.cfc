component {
	private string function datatable( event, rc, prc, args={} ) {

		args.eventDetails = _reorderData( args=args );
		
		return renderView(
			   view = "/renderers/notifications/eventFullyBooked/dataTable"
			 , args = args
		);
	}

	private string function full( event, rc, prc, args={} ) {

		args.eventDetails = _reorderData( args=args );

		return renderView(
			   view = "/renderers/notifications/eventFullyBooked/full"
			 , args = args
		);
	}

	private string function emailSubject( event, rc, prc, args={} ) {
		return "Event fully booked";
	}

	private string function emailHtml( event, rc, prc, args={} ) {

		args.eventDetails = _reorderData( args=deserializeJSON( args.data ?: "" ) );

		return renderView(
			  view = "/renderers/notifications/eventFullyBooked/emailHtml"
			, args = args
		);
	}

	private string function emailText( event, rc, prc, args={} ) {

		args.eventDetails = _reorderData( args=deserializeJSON( args.data ?: "" ) );
		
		return renderView(
			  view = "/renderers/notifications/eventFullyBooked/emailText"
			, args = args
		);
	}


	public struct function _reorderData(  args={} ) {

		var dataOrdered = structNew( "ordered" );

		dataOrdered.event_title     = args.event_details.title           ?: "";          
		dataOrdered.available_seats = args.event_details.available_seats ?: "";
		dataOrdered.booked_seats    = args.event_details.booked_seats    ?: "";   

		return dataOrdered;
	}


}