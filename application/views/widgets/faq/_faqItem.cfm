<cf_presideparam name="args.id" />
<cf_presideparam name="args.label"  default=""/>
<cf_presideparam name="args.answer" default=""/>
<cfoutput>
	<div class="faq-item">
		<p><strong>#args.label#</strong></p>
		<div class="faq-answer">
			#args.answer#
		</div>
	</div>
	<hr>
</cfoutput>