component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"         inject="EventService";

	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();

		return renderView( view='widgets/event/index', args=args );
	}

	private string function _renderSelectedEvents( event, rc, prc, args={} ) {

		args.selectedEvents = eventService.getSelectedEvents(selectedEvents=args.selectedEvents);

		return renderView(
			  view = "widgets/event/_selectedEvents"
			, args = args
		)
	}

}
