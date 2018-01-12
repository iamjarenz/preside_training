<cf_presideparam name="args.pageId"        field="page.id"                      />
<cf_presideparam name="args.parentId"      field="page.parent_page"             />
<cf_presideparam name="args.title"         field="page.title"               editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content"        editable="true" />
<cf_presideparam name="args.right_content" field="page.right_content"       editable="true" />
<cf_presideparam name="args.news_author"   field="news_detail.news_author"             />
<cf_presideparam name="args.publish_date"  field="news_detail.publish_date"          />
<cf_presideparam name="args.category"      field="news_detail.category"                    />

<cfoutput>


	<h1>#args.title# </h1>

	<div class="row">
		<div class="col-xs-12 col-md-8">
			<p><strong>Author:</strong> #args.news_author#</p>
			<p><strong>Published:</strong> #DateFormat(args.publish_date, "d mmm yyyy")#</p>
			<p><strong>Category:</strong> #renderLabel( recordId=args.category, objectName="category" )#</p>
			#renderViewlet( event="page-types.news_listing._renderNewsRegions", args={ newsDetailId=args.pageId } )#
			#args.main_content#
		</div>
		<div class="col-xs-12 col-md-4">
			#args.right_content#
		</div>
	</div>



	#renderViewlet( event="page-types.news_detail._relatedNewsViaRegion", args={ newsDetailId=args.pageId, parentPage=args.parentId } )#

</cfoutput>