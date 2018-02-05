<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>

=================================
Event details
=================================

Title: #( args.event_detail.title ?: "" )#
Start date: #dateFormat( args.event_detail.start_date, "dd-mmm-yyyy" )#
End date: #dateFormat( args.event_detail.end_date, "dd-mmm-yyyy" )#
<cfif len( args.event_detail.category ?: "" )>Category: #replace( args.event_detail.category, ",", ", ", "all" )#</cfif>
<cfif len( args.event_detail.region ?: "" )>Region: #replace( args.event_detail.region, ",", ", ", "all" )#</cfif>
<cfif len( args.event_detail.price ?: "" )>Price: &pound; #args.event_detail.price#</cfif>

	</cfif>
</cfoutput>