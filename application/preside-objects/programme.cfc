/**
* @dataManagerGroup Lookup
*/
component {
	property name="event_detail" relatedto="event_detail" relationship="many-to-one";
	property name="start_date"   type="date"              dbtype="datetime"           required=true;

}