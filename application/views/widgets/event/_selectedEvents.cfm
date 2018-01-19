<cf_presideparam name="args.id"         field="page.id"                 default="" />
<cf_presideparam name="args.title"      field="page.title"              default="" />
<cf_presideparam name="args.start_date" field="event_detail.start_date" default="" />
<cf_presideparam name="args.end_date"   field="event_detail.end_date"   default="" />

<cfoutput>

	<div class="events-item">
		<h4><a href="#event.buildLink( page=args.id )#">#args.title#</a></h4>
		<p>#dateFormat(args.start_date, "d mmm yyyy" )# - #dateFormat(args.end_date, "d mmm yyyy" )#</p>
	</div>
</cfoutput>