component {
	private string function datatable( event, rc, prc, args={} ) {
		args.memberDetails = _reorderData( event=event, args=args );
		
		return renderView(
			   view = "/renderers/notifications/newMemberRegistration/dataTable"
			 , args = args
		);
	}

	private string function full( event, rc, prc, args={} ) {

		args.memberDetails = _reorderData( event=event, args=args );

		return renderView(
			   view = "/renderers/notifications/newMemberRegistration/full"
			 , args = args
		);
	}

	private string function emailSubject( event, rc, prc, args={} ) {
		return "New member registration";
	}

	private string function emailHtml( event, rc, prc, args={} ) {

		args.memberDetails = _reorderData( event=event, args=deserializeJSON( args.data ?: "" ) );

		return renderView(
			  view = "/renderers/notifications/newMemberRegistration/emailHtml"
			, args = args
		);
	}

	private string function emailText( event, rc, prc, args={} ) {

		args.memberDetails = _reorderData( event=event, args=deserializeJSON( args.data ?: "" ) );

		return renderView(
			  view = "/renderers/notifications/newMemberRegistration/emailText"
			, args = args
		);
	}


	public struct function _reorderData(  event, args={} ) {

		var memberDataOrdered = structNew( "ordered" );

		memberDataOrdered.login_id      = args.member_details.login_id;
		memberDataOrdered.firstname     = args.member_details.personal.firstname       ?: "";
		memberDataOrdered.lastname      = args.member_details.personal.lastname        ?: "";
		memberDataOrdered.dob           = dateFormat( args.member_details.personal.dob ?: "", "dd-mmm-yyyy" );
		memberDataOrdered.email_address = args.member_details.personal.email           ?: "";
		memberDataOrdered.gender        = args.member_details.personal.gender          ?: "";
		memberDataOrdered.country       = args.member_details.personal.country         ?: "";
		memberDataOrdered.address       = args.member_details.personal.address         ?: "";
		memberDataOrdered.interests     = replace( args.member_details.interests       ?: "", ",", ", ", "all" );

		return memberDataOrdered;
	}


}