<cfscript>
	eventDetails = args.eventDetails ?: {};
</cfscript>
<cfoutput>
	<i class="fa fa-calendar-times-o"></i> #eventDetails.event_title ?: ""# is fully booked.
</cfoutput>