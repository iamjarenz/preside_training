<cfscript>
	userData = args.userData ?: {};
</cfscript>
<cfoutput>
Updated details for member #userData.display_name ?: ""#: 
<cfloop collection="#userData#" item="item">
#translateResource( 'preside-objects.website_user:field.#item#.title' )#: #userData["#item#"]#
</cfloop>

</cfoutput>