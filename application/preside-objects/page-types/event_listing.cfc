/**
 * @isSystemPageType       true
 * @allowedChildPageTypes  event_detail
 **/
component  {
	property name="items_per_page" type="numeric"           dbtype="integer";
	property name="category"       relatedto="category"     relationship="many-to-many"  relatedVia="event_listing_category";
	property name="event_detail"   relatedTo="event_detail" relationship="many-to-many" relatedVia="event_listing_detail";

}