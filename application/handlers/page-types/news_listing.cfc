component {
	
	property name="presideObjectService" inject="PresideObjectService";
	property name="newsService"          inject="NewsService";
	
	private function index( event, rc, prc, args={} ) {
		var pageId       = event.getCurrentPageId();
		var featuredNews = newsService.getFeaturedNews(newsListingId=pageId);


		args.activeRegionFilter   = rc.region   ?: "";
		args.activeCategoryFilter = rc.category ?: "";

		args.newsDetails          = newsService.getAllNewsDetail(
			  newsListingId         = pageId
			, activeRegionFilter    = args.activeRegionFilter
			, activeCategoryFilter  = args.activeCategoryFilter
			, excludeId             = valueList(featuredNews.id)
		);
		args.filterRegion         = newsService.getRegionFilters();
		args.filterCategory       = newsService.getCategoryFilters();

		return renderView(
			  view          = 'page-types/news_listing/index'
			, presideObject = 'news_listing'
			, id            = pageId
			, args          = args
		);
	}


	private string function _renderNewsRegions( event, rc, prc, args={} ) {

		args.regions = newsService.getNewsRegions(newsDetailId=args.newsDetailId);

		return renderView(
			  view = "page-types/news_listing/_regionList"
			, args = args
		)

	}
	private string function _renderFeaturedNews( event, rc, prc, args={} ) {

		args.featuredNews = newsService.getFeaturedNews(newsListingId=args.newsListingId);

		return renderView(
			  view = "page-types/news_listing/_featuredNews"
			, args = args
		)

	}

}
