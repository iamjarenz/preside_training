<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>

=================================
Booking details
=================================

First Name: #( args.booking_detail.firstname ?: "" )#
Last Name: #( args.booking_detail.lastname ?: "" )#
Email address: #( args.booking_detail.email ?: "" )#
Number of seats: #( args.booking_detail.number_seats ?: "" )#
Total amount: &pound; #( args.booking_detail.total_amount ?: "" )#
<cfif len( args.booking_detail.sessions ?: "" )>Sessions: #replace( args.booking_detail.sessions, ",", ", ", "all" )#</cfif>
<cfif len( args.booking_detail.special_request ?: "" )>Special request: #args.booking_detail.special_request#</cfif>

	</cfif>
</cfoutput>