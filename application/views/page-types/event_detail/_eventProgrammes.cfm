<cfscript>
	eventProgrammes = args.eventProgrammes ?: queryNew("");
</cfscript>

<cfoutput>

	<cfif eventProgrammes.recordCount >
		<hr>
		<h3>Programme list</h3>
		<hr>
		<cfloop query="eventProgrammes">
			<div>
				<h4>#label#</h4>
				<p><strong>Start date:</strong> #DateFormat(start_date)#</p>
			</div>
			<hr>
		</cfloop>
	</cfif>

</cfoutput>