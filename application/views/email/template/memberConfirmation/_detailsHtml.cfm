<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>
		<h4>Application details</h4>
		<table class="header-table" border="0" cellpadding="4" cellspacing="0">
			<tbody>
				<tr>
					<td>First Name</td>
					<td>#( args.personal.firstname ?: "" )#</td>
				</tr>
				<tr>
					<td>Lastname</td>
					<td>#( args.personal.lastname ?: "" )#</td>
				</tr>
				<tr>
					<td>Gender</td>
					<td>#( args.personal.gender ?: "" )#</td>
				</tr>
				<cfif len( args.personal.dob ?: "" ) && isDate( args.personal.dob )>
					<tr>
						<td>Date of birth</td>
						<td>#dateFormat( args.personal.dob, "dd-mmm-yyyy" )#</td>
					</tr>
				</cfif>
				<tr>
					<td>Email address</td>
					<td>#( args.personal.email ?: "" )#</td>
				</tr>

				<cfif len( args.personal.country ?: "" )>
					<tr>
						<td>Country</td>
						<td>#args.personal.country#</td>
					</tr>
				</cfif>
				<cfif len( args.personal.address ?: "" )>
					<tr>
						<td>Address</td>
						<td>#args.personal.address#</td>
					</tr>
				</cfif>

				<cfif len( args.interests ?: "" )>
					<tr>
						<td>Interests</td>
						<td>#replace( args.interests, ",", ", ", "all" )#</td>
					</tr>
				</cfif>

			</tbody>
		</table>
		
		<cfif event.isUKMember( args.personal.country ?: "" )>
			<p><strong>For UK Members only:</strong> You get a promotinal pacakge for registring! Yaaaay!</p>
		</cfif>
	</cfif>
</cfoutput>