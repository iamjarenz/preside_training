<cfscript>
	interceptData = args.interceptData ?: {};
	interceptData.delete('permissions');
	interceptData.delete('benefits');
	interceptData.delete('id');
	interceptData.delete('active');
</cfscript>
<cfoutput>
	<div class="well">
		<h4 class="green"><i class="fa fa-user"></i> Updated details for member #interceptData.display_name ?: ""#: </h4>
		<dl class="dl-horizontal">
			<cfloop collection="#interceptData#" item="item">
				<dt>#translateResource( 'preside-objects.website_user:field.#item#.title' )#</dt>
				<dd>#interceptData["#item#"]#</dd>
			</cfloop>
		</dl>
	</div>
</cfoutput>