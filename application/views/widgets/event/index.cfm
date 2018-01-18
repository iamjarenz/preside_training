<cf_presideparam name="args.title"       default="" />
<cf_presideparam name="args.event_items" default="" />

<cfoutput>

	<div class="widget widget-events">
		<cfif !isEmptyString(args.title)>
			<h3>#args.title#</h3>
		</cfif>
		#renderViewlet( event="widgets.event._renderSelectedEvents", args={ selectedEvents=args.event_items } )#
	</div>
</cfoutput>
