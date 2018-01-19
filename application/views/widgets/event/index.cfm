<cf_presideparam name="args.title"       default="" />
<cf_presideparam name="args.event_items" default="" />

<cfoutput>

	<div class="widget widget-events">
		<cfif !isEmptyString(args.title)>
			<h3>#args.title#</h3>
		</cfif>
		<div class="events-list">
			<cfloop list="#args.event_items#" item="id">
				#renderView( 
					  view          = "widgets/event/_selectedEvents"
					, presideObject = "event_detail" 
					, id            = id
				)#
			</cfloop>
		</div>

	</div>
</cfoutput>
