/**
* @dataManagerGroup Events
* @labelField event_detail
* @dataManagerGridFields event_detail,firstname,lastname,datecreated
*/
component {
	property name="event_detail"    relatedto="event_detail" relationship="many-to-one"  required=true;
	property name="firstname"       type="string"            dbtype="varchar"            required=true;
	property name="lastname"        type="string"            dbtype="varchar"            required=true;
	property name="email_address"   type="string"            dbtype="varchar"            required=true;
	property name="number_seats"    type="numeric"           dbtype="int"                required=true;
	property name="total_amount"    type="numeric"           dbtype="int"                required=true;
	property name="sessions"        relatedto="session" relationship="many-to-many" relatedvia="event_booking_sessions";
	property name="special_request" type="string"            dbtype="varchar";
}