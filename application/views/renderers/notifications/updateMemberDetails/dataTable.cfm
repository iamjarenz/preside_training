<cfscript>
	userData = args.userData ?: {};
	userData.delete('permissions');
	userData.delete('benefits');
	userData.delete('id');
	userData.delete('active');
</cfscript>
<cfoutput>
	<i class="fa fa-user"></i> #userData.display_name ?: "User"#'s details has been successfully updated.
</cfoutput>