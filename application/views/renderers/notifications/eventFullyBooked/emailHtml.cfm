<cfscript>
	eventDetails = args.eventDetails ?: {};
</cfscript>
<cfoutput>
	<h4>Event is fully booked:</h4>
	<table class="header-table" border="0" cellpadding="4" cellspacing="0">
		<cfloop collection="#eventDetails#" item="item">
			<tr>
				<td>#translateResource( 'page-types.event_detail:field.#item#.title' )#</td>
				<td>#eventDetails["#item#"]#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>