<cf_presideparam name="args.title" default="" />
<cf_presideparam name="args.video_id" default="" />
<cf_presideparam name="args.dimensions" default="" />

<cfscript>
	dimensions = listToArray(args.dimensions, "x");
</cfscript>

<cfoutput>

	<div class="widget widget-youtube">
		<cfif !isEmptyString(args.title)>
			<h3>#args.title#</h3>
		</cfif>
		<div class="iframe-wrap embed-responsive embed-responsive-16by9">
			<iframe class="embed-responsive-item" width="#dimensions[1]#" height="#dimensions[2]#" src="//www.youtube.com/embed/#args.video_id#" frameborder="0" allowfullscreen></iframe>
		</div>
		
	</div>
</cfoutput>
