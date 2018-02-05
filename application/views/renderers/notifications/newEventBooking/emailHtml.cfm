<cfscript>
	eventDetails = args.eventDetails ?: {};
	bookingDetails = args.bookingDetails ?: {};
</cfscript>
<cfoutput>
	<h4>Event booking details:</h4>
	<table class="header-table" border="0" cellpadding="4" cellspacing="0">
		<cfloop collection="#eventDetails#" item="item">
			<tr>
				<td>#translateResource( 'page-types.event_detail:field.#item#.title' )#</td>
				<td>#eventDetails["#item#"]#</td>
			</tr>
		</cfloop>
		<cfloop collection="#bookingDetails#" item="item">
			<tr>
				<td>#translateResource( 'preside-objects.event_booking:field.#item#.title' )#</td>
				<td>#bookingDetails["#item#"]#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>