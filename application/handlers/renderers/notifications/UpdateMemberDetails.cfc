component {
	private string function datatable( event, rc, prc, args={} ) {

		return renderView(
			   view = "/renderers/notifications/updateMemberDetails/dataTable"
			 , args = args
		);
	}

	private string function full( event, rc, prc, args={} ) {


		return renderView(
			   view = "/renderers/notifications/updateMemberDetails/full"
			 , args = args
		);
	}

	private string function emailSubject( event, rc, prc, args={} ) {
		return "Updated member details";
	}

	private string function emailHtml( event, rc, prc, args={} ) {

		args.interceptData = _reorderData( event=event, args=deserializeJSON( args.data ?: "" ) );

		return renderView(
			  view = "/renderers/notifications/updateMemberDetails/emailHtml"
			, args = args
		);
	}

	private string function emailText( event, rc, prc, args={} ) {

		args.interceptData = _reorderData( event=event, args=deserializeJSON( args.data ?: "" ) );

		return renderView(
			  view = "/renderers/notifications/updateMemberDetails/emailText"
			, args = args
		);
	}

	public struct function _reorderData(  event, args={} ) {

		var memberDataOrdered = structNew( "ordered" );

		memberDataOrdered.login_id      = args.interceptData.login_id      ?: "";
		memberDataOrdered.display_name  = args.interceptData.display_name  ?: "";
		memberDataOrdered.email_address = args.interceptData.email_address ?: "";

		return memberDataOrdered;
	}



}