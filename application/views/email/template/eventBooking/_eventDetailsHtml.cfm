<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>
		<h4>Event details</h4>
		<table class="header-table" border="0" cellpadding="4" cellspacing="0">
			<tbody>
				<tr>
					<td>Title</td>
					<td><a href="##">#( args.event_detail.title ?: "" )#</a></td>
				</tr>
				<cfif len( args.event_detail.start_date ?: "" ) && isDate( args.event_detail.start_date )>
					<tr>
						<td>Start date</td>
						<td>#dateFormat( args.event_detail.start_date, "dd-mmm-yyyy" )#</td>
					</tr>
				</cfif>

				<cfif len( args.event_detail.end_date ?: "" ) && isDate( args.event_detail.end_date )>
					<tr>
						<td>End date</td>
						<td>#dateFormat( args.event_detail.end_date, "dd-mmm-yyyy" )#</td>
					</tr>
				</cfif>

				<cfif len( args.event_detail.category ?: "" )>
					<tr>
						<td>Category</td>
						<td>#replace( args.event_detail.category, ",", ", ", "all" )#</td>
					</tr>
				</cfif>

				<cfif len( args.event_detail.region ?: "" )>
					<tr>
						<td>Region</td>
						<td>#replace( args.event_detail.region, ",", ", ", "all" )#</td>
					</tr>
				</cfif>

				<cfif len( args.price ?: "" )>
					<tr>
						<td>Price</td>
						<td>&pound; #args.event_detail.price#</td>
					</tr>
				</cfif>

			</tbody>
		</table>
	</cfif>
</cfoutput>