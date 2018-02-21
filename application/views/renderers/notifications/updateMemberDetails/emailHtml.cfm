<cfscript>
	userData = args.userData ?: {};
</cfscript>
<cfoutput>
	<h4>Updated details for member #userData.display_name ?: ""#:</h4>
	<table class="header-table" border="0" cellpadding="4" cellspacing="0">
		<cfloop collection="#userData#" item="item">
			<tr>
				<td>#translateResource( 'preside-objects.website_user:field.#item#.title' )#</td>
				<td>#userData["#item#"]#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>