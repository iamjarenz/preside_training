<cfscript>
	selectedEvents = args.selectedEvents ?: queryNew("");
</cfscript>

<cfoutput>


	<div class="events-list">
		<cfloop query="selectedEvents">
			<div class="events-item">
				<h4><a href="#event.buildLink( page=id )#">#title#</a></h4>
				<p>#dateFormat(start_date, "d mmm yyyy" )# - #dateFormat(end_date, "d mmm yyyy" )#</p>
			</div>
		</cfloop>
	</div>
</cfoutput>