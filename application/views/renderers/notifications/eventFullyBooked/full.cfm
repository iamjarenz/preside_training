<cfscript>
	eventDetails = args.eventDetails ?: {};
</cfscript>
<cfoutput>
	<div class="well">
		#dump(args)#
		<h4 class="green"><i class="fa fa-calendar"></i> Event is fully booked:</h4>
		<dl class="dl-horizontal">
			<cfloop collection="#eventDetails#" item="item">
				<dt>#translateResource( 'page-types.event_detail:field.#item#.title' )#</dt>
				<dd>#eventDetails["#item#"]#</dd>
			</cfloop>
		</dl>
	</div>
</cfoutput>