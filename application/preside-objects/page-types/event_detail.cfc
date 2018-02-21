/**
 * @allowedParentPageTypes event_listing
 * @allowedChildPageTypes  none
 * @showInSiteTree         false
 */

component  {
	property name="start_date"  type="date"              dbtype="datetime"           required=true;
	property name="end_date"    type="date"              dbtype="datetime"           required=true;
	property name="region"      relatedto="region"       relationship="many-to-many" relatedvia="event_detail_region" quickadd=true      quickedit=true;
	property name="category"    relatedto="category"     relationship="many-to-one"  quickadd=true      quickedit=true;
	property name="programmes"  relatedto="programme"    relationship="one-to-many"  quickadd=true      quickedit=true relationshipkey="event_detail";
	property name="documents"   relatedTo="asset"        relationship="many-to-one";

	property name="bookable"        type="boolean" dbtype="boolean";
	property name="price"           type="numeric" dbtype="int"     required=true;
	property name="available_seats" type="numeric" dbtype="int"     required=true;
	property name="booked_seats"    type="numeric" dbtype="int"     default=0;
	property name="sessions"  relatedto="session"    relationship="one-to-many"  quickadd=true      quickedit=true relationshipkey="event_detail";
}