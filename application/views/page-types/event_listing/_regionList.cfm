<cfscript>
	regions = args.regions ?: queryNew("");
</cfscript>

<cfoutput>

	<cfif regions.recordCount >
		<p> 
			<strong>Regions:</strong>
			<cfset ctr="1">
			<cfloop query="regions">
				#label#<cfif ctr !=  regions.recordCount>, </cfif>
				<cfset ctr++>
			</cfloop>
		</p>
	</cfif>
</cfoutput>