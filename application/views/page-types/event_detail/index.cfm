<cf_presideparam name="args.pageId"         field="page.id" />
<cf_presideparam name="args.slug"           field="page.slug" />
<cf_presideparam name="args.parentId"       field="page.parent_page"             />
<cf_presideparam name="args.title"          field="page.title"          editable="true" />
<cf_presideparam name="args.main_content"   field="page.main_content"   editable="true" />
<cf_presideparam name="args.right_content"  field="page.right_content"  editable="true" />
<cf_presideparam name="args.bottom_content" field="page.bottom_content" editable="true" />
<cf_presideparam name="args.start_date"     field="event_detail.start_date" />
<cf_presideparam name="args.end_date"       field="event_detail.end_date" />
<cf_presideparam name="args.category"       field="event_detail.category" />
<cf_presideparam name="args.documents"      field="event_detail.documents" />
<cf_presideparam name="args.bookable"      field="event_detail.bookable" />


<cfoutput>

	<div class="row">
		<div class="col-xs-12 col-md-8">
			<h1>#args.title#</h1>
			<p><strong>Start date:</strong> #DateFormat(args.start_date, "d mmm yyyy")#</p>
			<p><strong>End date:</strong> #DateFormat(args.end_date, "d mmm yyyy")#</p>
			<p><strong>Category:</strong> #renderLabel( recordId=args.category, objectName="category" )#</p>
			#renderViewlet( event="page-types.event_listing._renderEventRegions", args={ eventDetailId=args.pageId } )#
			<div>
				#args.main_content#
			</div>
			
			#renderViewlet( event="page-types.event_detail._renderEventProgrammes", args={ eventDetailId=args.pageId } )#
			
			<cfif args.start_date < now()>
				<cfif !isEmptyString(args.documents)>
					<div class="document">
						<a href="#event.buildLink(assetId=args.documents)#">#renderAsset( assetId=args.documents )# Download Document</a>
					</div>
					<br>
				</cfif>

				<div id="disqus_thread"></div>
				<br>
			</cfif>
		</div>
		<div class="col-xs-12 col-md-4">
			<cfif isTrue(args.bookable)>
				<div class="widget widget-booking">
					<a href="#event.buildLink( page="event_booking_page", queryString="ev=#args.slug#" )#" class="btn btn-primary btn-block">Book now</a>
				</div>
				<hr>
			</cfif>
			#args.right_content#
		</div>
	</div>

	<div>
		#args.bottom_content#
	</div>

	#renderViewlet( event="page-types.event_detail._renderRelatedEvents", args={ eventDetailId=args.pageId, parentPage=args.parentId  } )#

</cfoutput>