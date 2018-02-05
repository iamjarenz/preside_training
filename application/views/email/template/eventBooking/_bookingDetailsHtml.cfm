<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>
		<h4>Booking details</h4>
		<table class="header-table" border="0" cellpadding="4" cellspacing="0">
			<tbody>
				<tr>
					<td>First Name</td>
					<td>#( args.booking_detail.firstname ?: "" )#</td>
				</tr>
				<tr>
					<td>Lastname</td>
					<td>#( args.booking_detail.lastname ?: "" )#</td>
				</tr>
				<tr>
					<td>Email address</td>
					<td>#( args.booking_detail.email ?: "" )#</td>
				</tr>
				<tr>
					<td>Number of seats</td>
					<td>#( args.booking_detail.number_seats ?: "" )#</td>
				</tr>
				<tr>
					<td>Total amount</td>
					<td>&pound; #( args.booking_detail.total_amount ?: "" )#</td>
				</tr>
				<cfif len( args.booking_detail.sessions ?: "" )>
					<tr>
						<td>Sessions</td>
						<td>#replace( args.booking_detail.sessions, ",", ", ", "all" )#</td>
					</tr>
				</cfif>
				<cfif len( args.booking_detail.special_request ?: "" )>
					<tr>
						<td>Special request</td>
						<td>#args.booking_detail.special_request#</td>
					</tr>
				</cfif>


			</tbody>
		</table>
	</cfif>
</cfoutput>