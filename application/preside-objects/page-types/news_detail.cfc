/**
 * @allowedParentPageTypes news_listing
 * @allowedChildPageTypes  none
 * @showInSiteTree         false
 */

component  {
	property name="publish_date" type="date"              dbtype="datetime"           required=true;
	property name="news_author"  type="string"            dbtype="varchar"            required=true;
	property name="region"       relatedto="region"       relationship="many-to-many" relatedvia="news_detail_region" quickadd=true      quickedit=true;
	property name="category"     relatedto="category"     relationship="many-to-one"  quickadd=true      quickedit=true;
}