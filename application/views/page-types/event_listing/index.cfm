<cf_presideparam name="args.pageId"          field="page.id"                      />
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.items_per_page" editable="true" />

<cfscript>
	eventDetails         = args.eventDetails         ?: queryNew("");
	filterRegion         = args.filterRegion         ?: queryNew("");
	activeRegionFilter   = args.activeRegionFilter   ?: "";
</cfscript>

<cfoutput>

	<h1>#args.title#</h1>
	<div>
		#args.main_content#
	</div>

	<div>
		<h4>Featured</h4>
		#renderViewlet( event="page-types.event_listing._renderFeaturedEvent", args={ eventListingId=args.pageId } )#
	</div>
	<div class="row">
		<div class="col-xs-12 col-md-9">
			#renderViewlet( event="page-types.event_listing._renderEventCategoryFilter", args={ eventListingId=args.pageId } )#
			
			<cfif !isEmptyString( activeRegionFilter ) >
				<h4>Active filters</h4>
				<ul>
					<cfloop list="#activeRegionFilter#" item="item" >
						<li>#renderLabel( recordId=item, objectName="region" )#</li>
					</cfloop>
				</ul>
			</cfif>

			
			<cfif eventDetails.recordCount >

				<div class="row">

					<cfloop query="eventDetails" >
						<div class="col-xs-12 col-sm-6">
							<h3><a href="#event.buildLink( page=id )#">#title#</a></h3>
							<p><strong>Start date:</strong> #dateFormat(start_date, "d mmm yyyy" )#</p>
							<p><strong>End date:</strong> #dateFormat(end_date, "d mmm yyyy" )#</p>
							<p><strong>Category:</strong> #category_label#</p>
							#renderViewlet( event="page-types.event_listing._renderEventRegions", args={ eventDetailId=id } )#
						</div>
					</cfloop>

				</div>
			<cfelse >
				<p>No record found.</p>
			</cfif>

		</div>
		<div class="col-xs-12 col-md-3">
					
			<h3>Filters</h3>

			<form action="#event.buildLink( page=args.pageId )#" method="get" >
				<h5>Regions</h5>
				<cfloop query="filterRegion" >
					<div>
						<label>
							<input type="checkbox" name="region" value="#id#" <cfif listFind(activeRegionFilter, id) > checked </cfif> >
							#label#
						</label>
					</div>
				</cfloop>
				<input type="submit" value="Submit" >
			</form>

		</div>

	</div>
</cfoutput>