<cfscript>
	userData = args.userData ?: {};
	userData.delete('permissions');
	userData.delete('benefits');
	userData.delete('id');
	userData.delete('active');
</cfscript>
<cfoutput>
	<div class="well">
		<h4 class="green"><i class="fa fa-user"></i> Updated details for member #userData.display_name ?: ""#: </h4>
		<dl class="dl-horizontal">
			<cfloop collection="#userData#" item="item">
				<dt>#translateResource( 'preside-objects.website_user:field.#item#.title' )#</dt>
				<dd>#userData["#item#"]#</dd>
			</cfloop>
		</dl>
	</div>
</cfoutput>