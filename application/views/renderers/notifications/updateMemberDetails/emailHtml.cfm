<cfscript>
	interceptData = args.interceptData ?: {};
</cfscript>
<cfoutput>
	<h4>Updated details for member #interceptData.display_name ?: ""#:</h4>
	<table class="header-table" border="0" cellpadding="4" cellspacing="0">
		<cfloop collection="#interceptData#" item="item">
			<tr>
				<td>#translateResource( 'preside-objects.website_user:field.#item#.title' )#</td>
				<td>#interceptData["#item#"]#</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>