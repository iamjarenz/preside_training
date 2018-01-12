<cfscript>
	relatedNews = args.relatedNews ?: queryNew("");
</cfscript>

<cfoutput>

	<cfif relatedNews.recordCount >
		<h3>Related news (Regions)</h3>

		<div class="row">

			<cfloop query="relatedNews" >
				<div class="col-xs-12 col-sm-4">
					<h3><a href="#event.buildLink( page=id )#">#title#</a></h3>
					<p><strong>Author:</strong> #news_author#</p>
					<p><strong>Date:</strong> #dateFormat(publish_date, "d mmm yyyy" )#</p>
					<p><strong>Category:</strong> #category_label#</p>
					#renderViewlet( event="page-types.news_listing._renderNewsRegions", args={ newsDetailId=id } )#
				</div>
			</cfloop>

		</div>
	</cfif>

</cfoutput>