<cfscript>
	eventDetails = args.eventDetails ?: {};
</cfscript>
<cfoutput>
Event is fully booked:
<cfloop collection="#eventDetails#" item="item">
#translateResource( 'page-types.event_detail:field.#item#.title' )#: #eventDetails["#item#"]#
</cfloop>
</cfoutput>