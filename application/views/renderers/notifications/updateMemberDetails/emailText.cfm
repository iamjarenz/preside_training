<cfscript>
	interceptData = args.interceptData ?: {};
</cfscript>
<cfoutput>
Updated details for member #interceptData.display_name ?: ""#: 
<cfloop collection="#interceptData#" item="item">
#translateResource( 'preside-objects.website_user:field.#item#.title' )#: #interceptData["#item#"]#
</cfloop>

</cfoutput>