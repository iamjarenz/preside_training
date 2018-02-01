/**
* @noLabel true
* @dataManagerGridFields firstname,lastname,datecreated
*/

component {
	property name="firstname"    type="string"        dbtype="varchar"  required=true;
	property name="lastname"     type="string"        dbtype="varchar"  required=true;
	property name="dob"          type="date"          dbtype="date"     required=true;
	property name="address"      type="string"        dbtype="varchar"  ;
	property name="gender"       type="string"        dbtype="varchar"  ;
	property name="category"     relatedto="category" relationship="many-to-many" relatedvia="user_interests";

}