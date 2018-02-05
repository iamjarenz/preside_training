<cfscript>
	eventDetails = args.eventDetails ?: {};
	bookingDetails = args.bookingDetails ?: {};
</cfscript>
<cfoutput>
	<div class="well">
		<h4 class="green"><i class="fa fa-calendar"></i> Event booking details:</h4>
		<dl class="dl-horizontal">
			<cfloop collection="#eventDetails#" item="item">
				<dt>#translateResource( 'page-types.event_detail:field.#item#.title' )#</dt>
				<dd>#eventDetails["#item#"]#</dd>
			</cfloop>
			<cfloop collection="#bookingDetails#" item="item">
				<dt>#translateResource( 'preside-objects.event_booking:field.#item#.title' )#</dt>
				<dd>#bookingDetails["#item#"]#</dd>
			</cfloop>
		</dl>
	</div>
</cfoutput>