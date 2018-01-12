/**
 * @isSystemPageType       true
 * @allowedChildPageTypes  news_detail
 **/
component  {
	property name="items_per_page" type="numeric" dbtype="integer";
	property name="news_detail"    relatedTo="news_detail" relationship="many-to-many" relatedVia="news_listing_detail";
	

}