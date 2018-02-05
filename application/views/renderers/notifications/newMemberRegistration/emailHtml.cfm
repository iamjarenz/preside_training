<cfscript>
	memberDetails = args.memberDetails ?: {};
</cfscript>
<cfoutput>
	<h4>Member details for #memberDetails.firstname ?: ""# #memberDetails.lastname ?: ""#: </h4>
	<table class="header-table" border="0" cellpadding="4" cellspacing="0">
		<cfloop collection="#memberDetails#" item="item">
			<tr>
				<td>#translateResource( 'preside-objects.user_detail:field.#item#.title' )#</td>
				<td>#memberDetails["#item#"]#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>