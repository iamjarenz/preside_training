<cf_presideparam name="args.title"      default="" />
<cf_presideparam name="args.faq_item"   default=""     />

<cfscript>
	selectedFaqItems = args.faq_item ?: "";
</cfscript>

<cfoutput>

	<div class="widget widget-faq">
		<cfif !isEmptyString(args.title) >
			<h4>#args.title#</h4>
		</cfif>
		<cfif !isEmptyString(selectedFaqItems) >
			<hr>
			#renderView( 
				  view         = "widgets/faq/_faqItem"
				, presideObject= "faq_item" 
				, filter        = { id = listToArray( selectedFaqItems ) }
				, orderBy       = "FIELD( id, #listQualify( selectedFaqItems, "'" )# )"
			)#
		</cfif>
	</div>

</cfoutput>
