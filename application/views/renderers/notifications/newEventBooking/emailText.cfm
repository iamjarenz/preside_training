<cfscript>
	eventDetails = args.eventDetails ?: {};
	bookingDetails = args.bookingDetails ?: {};
</cfscript>
<cfoutput>
Event booking details:
<cfloop collection="#eventDetails#" item="item">
#translateResource( 'page-types.event_detail:field.#item#.title' )#: #eventDetails["#item#"]#
</cfloop>
<cfloop collection="#bookingDetails#" item="item">
#translateResource( 'preside-objects.event_booking:field.#item#.title' )#: #bookingDetails["#item#"]#
</cfloop>
</cfoutput>