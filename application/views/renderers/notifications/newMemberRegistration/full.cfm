<cfscript>
	memberDetails = args.memberDetails ?: {};
</cfscript>
<cfoutput>
	<div class="well">
		<h4 class="green"><i class="fa fa-user"></i> Member details for #memberDetails.firstname ?: ""# #memberDetails.lastname ?: ""#: </h4>
		<dl class="dl-horizontal">
			<cfloop collection="#memberDetails#" item="item">
				<dt>#translateResource( 'preside-objects.user_detail:field.#item#.title' )#</dt>
				<dd>#memberDetails["#item#"]#</dd>
			</cfloop>
		</dl>
	</div>
</cfoutput>