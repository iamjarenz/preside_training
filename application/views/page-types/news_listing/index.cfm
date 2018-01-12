<cf_presideparam name="args.pageId"          field="page.id"                      />
<cf_presideparam name="args.title"           field="page.title"                   editable="true" />
<cf_presideparam name="args.main_content"    field="page.main_content"            editable="true" />

<cfscript>
	newsDetails          = args.newsDetails          ?: queryNew("");
	activeRegionFilter   = args.activeRegionFilter   ?: "";
	activeCategoryFilter = args.activeCategoryFilter ?: "";
</cfscript>

<cfoutput>
	

	<h1>#args.title#</h1>
	<div>
		#args.main_content#
	</div>
	<div>
		<h4>Featured</h4>
		#renderViewlet( event="page-types.news_listing._renderFeaturedNews", args={ newsListingId=args.pageId } )#
	</div>
	<div class="row">
		<div class="col-xs-12 col-md-9">
			
			<cfif !isEmptyString( activeRegionFilter ) >
				<h4>Active filters</h4>
				<ul>
					<cfloop list="#activeRegionFilter#" item="item" >
						<li>#renderLabel( recordId=item, objectName="region" )#</li>
					</cfloop>
					<cfloop list="#activeCategoryFilter#" item="item" >
						<li>#renderLabel( recordId=item, objectName="category" )#</li>
					</cfloop>
				</ul>
			</cfif>

			
			<cfif newsDetails.recordCount >

				<div class="row">

					<cfloop query="newsDetails" >
						<div class="col-xs-12 col-sm-6">
							<h3><a href="#event.buildLink( page=id )#">#title#</a></h3>
							<p><strong>Author:</strong> #news_author#</p>
							<p><strong>Date:</strong> #dateFormat(publish_date, "d mmm yyyy" )#</p>
							<p><strong>Category:</strong> #category_label#</p>
							#renderViewlet( event="page-types.news_listing._renderNewsRegions", args={ newsDetailId=id } )#
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
				<cfloop query="args.filterRegion" >
					<div>
						<label>
							<input type="checkbox" name="region" value="#id#" <cfif listFind(activeRegionFilter, id) > checked </cfif> >
							#label#
						</label>
					</div>
				</cfloop>
				<h5>Category</h5>
				<cfloop query="args.filterCategory" >
					<div>
						<label>
							<input type="checkbox" name="category" value="#id#" <cfif listFind(activeCategoryFilter, id) > checked </cfif> >
							#label#
						</label>
					</div>
				</cfloop>
				<input type="submit" value="Submit" >
			</form>

		</div>
	</div>




</cfoutput>