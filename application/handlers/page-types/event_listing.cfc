component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"         inject="EventService";

	private function index( event, rc, prc, args={} ) {
		var pageId               = event.getCurrentPageId();
		var featuredEvent        = eventService.getFeaturedEvents(eventListingId=pageId);
		var activeCategoryFilter = eventService.getEventCategoryFilter(eventListingId=pageId);


		args.activeRegionFilter   = rc.region   ?: "";

		args.eventDetails = eventService.getAllEventDetail(
			  eventListingId        = pageId
			, activeRegionFilter    = args.activeRegionFilter
			, activeCategoryFilter  = valueList(activeCategoryFilter.id)
			, excludeFeaturedEvent  = valueList(featuredEvent.id)
		);
		args.filterRegion         = eventService.getRegionFilters();
		args.filterCategory       = eventService.getCategoryFilters();

		return renderView(
			  view          = 'page-types/event_listing/index'
			, presideObject = 'event_listing'
			, id            = pageId
			, args          = args
		);
	}


	private string function _renderEventRegions( event, rc, prc, args={} ) {

		args.regions = eventService.getEventRegions(eventDetailId=args.eventDetailId);

		return renderView(
			  view = "page-types/event_listing/_regionList"
			, args = args
		)

	}
	private string function _renderFeaturedEvent( event, rc, prc, args={} ) {

		args.featuredEvent = eventService.getFeaturedEvents(eventListingId=args.eventListingId);

		return renderView(
			  view = "page-types/event_listing/_featuredEvents"
			, args = args
		)

	}
	private string function _renderEventCategoryFilter( event, rc, prc, args={} ) {

		args.activeCategoryFilter = eventService.getEventCategoryFilter(eventListingId=args.eventListingId);

		return renderView(
			  view = "page-types/event_listing/_activeCategoryFilter"
			, args = args
		)

	}
}
