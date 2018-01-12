<cfscript>
	featuredEvents = args.featuredEvent ?: queryNew("");
</cfscript>
<cfoutput>
	<cfif featuredEvents.recordCount >
		<div class="row">

			<cfloop query="featuredEvents" >
				<div class="col-xs-12 col-sm-4">
					<h3><a href="#event.buildLink( page=id )#">#title#</a></h3>
					<p><strong>Start date:</strong> #dateFormat(start_date, "d mmm yyyy" )#</p>
					<p><strong>End date:</strong> #dateFormat(end_date, "d mmm yyyy" )#</p>
					<p><strong>Category:</strong> #category_label#</p>
					#renderViewlet( event="page-types.event_listing._renderEventRegions", args={ eventDetailId=id } )#
				</div>
			</cfloop>

		</div>
		<hr>
	</cfif>
</cfoutput>