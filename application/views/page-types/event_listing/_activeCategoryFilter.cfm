<cfscript>
	activeCategoryFilter = args.activeCategoryFilter ?: "";
</cfscript>

<cfoutput>

	<cfif activeCategoryFilter.recordCount >
		<p>
			<strong>Active Category Filter: </strong>
			<cfset ctr="1">
			<cfloop query="activeCategoryFilter" >
				#label#<cfif ctr !=  activeCategoryFilter.recordCount>, </cfif>
				<cfset ctr++>
			</cfloop>
		</p>

	</cfif>	
</cfoutput>