<cfscript>
	memberDetails = args.memberDetails ?: {};
</cfscript>
<cfoutput>
Member details for #memberDetails.firstname ?: ""# #memberDetails.lastname ?: ""#: 
<cfloop collection="#memberDetails#" item="item">
#translateResource( 'preside-objects.user_detail:field.#item#.title' )#: #memberDetails["#item#"]#
</cfloop>
</cfoutput>