component {

	property name="presideObjectService" inject="PresideObjectService";


	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();
		var event_slug = rc.ev ?: "";

		args.event_detail = presideObjectService.selectData(
			selectFields = [
				  "event_detail.id"
				, "page.title"
				, "event_detail.price"
			]
			, objectName = "event_detail"
			, filter     = { "page.slug" = event_slug }
		);

		if( ! args.event_detail.recordCount ) {
			event.notFound();
		} 
		else {
			args.session = presideObjectService.selectData(
				selectFields = [
					  "session.id"
					, "session.label"
				]
				, objectName = "session"
				, filter     = { "session.event_detail" = args.event_detail.id }
				, orderBy    = "session.label ASC"
			);
		}




		return renderView(
			  view          = 'page-types/event_booking_page/index'
			, presideObject = 'event_booking_page'
			, id            = pageId
			, args          = args
		);
	}
}
