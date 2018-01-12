<cf_presideparam name="args.title"      default="" />
<cf_presideparam name="args.quick_link" default=""     />

<cfoutput>

	<div class="widget widget-quicklink">
		<cfif !isEmptyString(args.title) >
			<h4>#args.title#</h4>
		</cfif>

		<ul>
			<cfloop list="#args.quick_link#" item="item">
				<li>#renderLink( id=item )#</li>
			</cfloop>
		</ul>
	</div>

</cfoutput>
