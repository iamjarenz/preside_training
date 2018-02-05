<cfscript>
	eventDetails = args.eventDetails ?: {};
	bookingDetails = args.bookingDetails ?: {};
</cfscript>
<cfoutput>
	<i class="fa fa-calendar"></i> #bookingDetails.firstname ?: ""# #bookingDetails.lastname ?: ""# just booked an event for #eventDetails.title ?: ""#.
</cfoutput>