component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="newsService"          inject="NewsService";

	private function index( event, rc, prc, args={} ) {
		var pageId = event.getCurrentPageId();

		return renderView(
			  view          = 'page-types/news_detail/index'
			, presideObject = "news_detail"
			, id            = pageId
			, args          = args
		);

	}

	private string function _relatedNewsViaRegion( event, rc, prc, args={} ) {

		var regions = newsService.getNewsRegions(newsDetailId=args.newsDetailId);

		args.relatedNews = newsService.getAllNewsDetail(
			  newsListingId      = args.parentPage
			, activeRegionFilter = valueList(regions.id)
			, excludeCurrentId   = args.newsDetailId
		);

		return renderView(
			  view = "page-types/news_detail/_relatedNews"
			, args = args
		)
	}
}