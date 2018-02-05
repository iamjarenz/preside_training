<cfscript>
	memberDetails = args.memberDetails ?: {};
</cfscript>
<cfoutput>
	<i class="fa fa-user"></i> #memberDetails.firstname ?: ""# #memberDetails.lastname ?: ""# just registered successfully.
</cfoutput>