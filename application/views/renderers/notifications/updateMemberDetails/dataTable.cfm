<cfscript>
	interceptData = args.interceptData ?: {};
	interceptData.delete('permissions');
	interceptData.delete('benefits');
	interceptData.delete('id');
	interceptData.delete('active');
</cfscript>
<cfoutput>
	<i class="fa fa-user"></i> #interceptData.display_name ?: "User"#'s details has been successfully updated.
</cfoutput>