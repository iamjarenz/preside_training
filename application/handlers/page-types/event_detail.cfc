component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"         inject="EventService";

	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();

		return renderView(
			  view          = 'page-types/event_detail/index'
			, presideObject = "event_detail"
			, id            = pageId
			, args          = args
		);

	}

	private string function _renderEventProgrammes( event, rc, prc, args={} ) {
		args.eventProgrammes = eventService.getEventProgrammes(
			  eventDetailId = args.eventDetailId
		);

		return renderView(
			  view = "page-types/event_detail/_eventProgrammes"
			, args = args
		)
	}


	private string function _renderRelatedEvents( event, rc, prc, args={} ) {

		var regions = eventService.getEventRegions(eventDetailId=args.eventDetailId);

		args.relatedEvents = eventService.getAllEventDetail(
			  eventListingId      = args.parentPage
			, activeRegionFilter = valueList(regions.id)
			, excludeId          = args.eventDetailId
		);

		return renderView(
			  view = "page-types/event_detail/_relatedEvents"
			, args = args
		)
	}
}