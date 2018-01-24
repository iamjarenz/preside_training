/**
 * @presideService
 */
component {

    public any function init() {
        return this;
    }

    public query function getAllEventDetail(
    	  required string eventListingId
    	,          string activeRegionFilter   = ""
    	,          string activeCategoryFilter = ""
    	,          string excludeId            = ""
    ) {
    	var filter = "page.parent_page = '#arguments.eventListingId#' AND event_detail.start_date >= DATE(" & now() & ")";


		if( len( trim( arguments.activeRegionFilter ) ) ) {
			filter &= " AND event_detail_region.region IN ( " & listQualify(arguments.activeRegionFilter, "'" ) & ")"
		}
		if( len( trim( arguments.activeCategoryFilter ) ) ) {
			filter &= " AND event_detail.category IN ( " & listQualify(arguments.activeCategoryFilter, "'" ) & ")";
		}
		if( len( trim( arguments.excludeId ) ) ) {
			filter &= " AND page.id NOT IN ( " & listQualify(arguments.excludeId, "'" ) & ")";
		}


		var newsDetails = $getPresideObjectService().selectData(
			selectFields = [
				  "event_detail.id"
				, "page.title"
				, "event_detail.start_date"
				, "event_detail.end_date"
				, "event_detail.category"
				, "category.label as category_label"
			]
			, objectName = "event_detail"
			, filter     = filter
			, orderBy    = "event_detail.start_date ASC"

		);

		return newsDetails;
    }
    public query function getRegionFilters() {

		return $getPresideObject( "region" ).selectData(
			  selectFields = [ "region.id", "region.label" ]
			, orderBy      = "region.label ASC"
		);

    }
    public query function getCategoryFilters() {

		return $getPresideObject( "category" ).selectData(
			  selectFields = [ "category.id", "category.label" ]
			, orderBy      = "category.label ASC"
		);

    }
    public query function getEventRegions(
    	  required string eventDetailId
    ) {

    	return  $getPresideObjectService().selectData(
			  objectName   = "event_detail_region"
			, selectFields = [ "region.id", "region.label", ]
			, filter       = { "event_detail_region.event_detail" = arguments.eventDetailId }
			, orderBy      = "region.label ASC"
		);

    }

    public query function getFeaturedEvents( required string eventListingId ) {

		var featuredEvent = $getPresideObjectService().selectData(
			  objectName = "event_listing_detail"
			, selectFields = [
				  "event_detail.id"
				, "event_detail$page.title"
				, "event_detail.start_date"
				, "event_detail.end_date"
				, "event_detail.category"
				, "category.label as category_label"
			]
			, filter  = { "event_detail$page.parent_page" = eventListingId }
			, orderBy = "event_detail.start_date ASC"
		);

		return featuredEvent;

    }


    public query function getSelectedEvents( required string selectedEvents ) {

		var selectedEvents = $getPresideObjectService().selectData(
			  objectName = "event_detail"
			, selectFields = [
				  "event_detail.id"
				, "page.title"
				, "event_detail.start_date"
				, "event_detail.end_date"
				, "event_detail.category"
				, "category.label as category_label"
			]
			, filter  = "page.id IN ( " & listQualify(arguments.selectedEvents, "'" ) & ")"
			, orderBy = "event_detail.start_date ASC"
		);

		return selectedEvents;

    }

    public query function getEventCategoryFilter( required string eventListingId )  {

    	return  $getPresideObjectService().selectData(
			  objectName   = "event_listing_category"
			, selectFields = [ "category.id", "category.label", ]
			, filter       = { "event_listing_category.event_listing" = arguments.eventListingId }
			, orderBy      = "category.label ASC"
		);

    }
    public query function getEventProgrammes( required string eventDetailId )  {

    	return  $getPresideObjectService().selectData(
			  objectName   = "programme"
			, selectFields = [ "programme.id", "programme.label", "programme.start_date" ]
			, filter       = { "programme.event_detail" = arguments.eventDetailId }
			, orderBy      = "programme.start_date ASC"
		);

    }
}