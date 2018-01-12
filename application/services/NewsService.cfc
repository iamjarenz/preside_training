/**
 * @presideService
 */
component {

    public any function init() {
        return this;
    }

    public query function getAllNewsDetail(
    	  required string newsListingId
    	,          string activeRegionFilter   = ""
    	,          string activeCategoryFilter = ""
    	,          string excludeCurrentId     = ""
    	,          string excludeFeaturedNews  = ""
    ) {
    	var filter = "page.parent_page = '#arguments.newsListingId#' AND news_detail.publish_date <= DATE(" & now() & ")";

		if( len( trim( arguments.activeRegionFilter ) ) ) {
			filter &= " AND news_detail_region.region IN ( " & listQualify(arguments.activeRegionFilter, "'" ) & ")"
		}
		if( len( trim( arguments.activeCategoryFilter ) ) ) {
			filter &= " AND news_detail.category IN ( " & listQualify(arguments.activeCategoryFilter, "'" ) & ")";
		}
		if( len( trim( arguments.excludeCurrentId ) ) ) {
			filter &= " AND page.id != '" & arguments.excludeCurrentId & "'";
		}
		if( len( trim( arguments.excludeFeaturedNews ) ) ) {
			filter &= " AND page.id NOT IN ( " & listQualify(arguments.excludeFeaturedNews, "'" ) & ")";
		}


		var newsDetails = $getPresideObjectService().selectData(
			selectFields = [
				  "news_detail.id"
				, "page.title"
				, "news_detail.news_author"
				, "news_detail.publish_date"
				, "news_detail.category"
				, "category.label as category_label"
			]
			, objectName = "news_detail"
			, filter     = filter
			, orderBy    = "news_detail.publish_date DESC"

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

    public query function getNewsRegions(
    	  required string newsDetailId
    ) {

    	return  $getPresideObjectService().selectData(
			  objectName   = "news_detail_region"
			, selectFields = [ "region.id", "region.label", ]
			, filter       = { "news_detail_region.news_detail" = arguments.newsDetailId }
			, orderBy      = "region.label ASC"
		);

    }


    public query function getFeaturedNews( required string newsListingId ) {

		var featuredNews = $getPresideObjectService().selectData(
			  objectName = "news_listing_detail"
			, selectFields = [
				  "news_detail.id"
				, "news_detail$page.title"
				, "news_detail.news_author"
				, "news_detail.publish_date"
				, "news_detail.category"
				, "category.label as category_label"
			]
			, filter  = { "news_detail$page.parent_page" = newsListingId }
			, orderBy = "news_detail.publish_date DESC"
		);

		return featuredNews;

    }

}