<!---
	This view file has been automatically created by the preside dev tools
	scaffolder. Please fill with meaningful content and remove this comment
--->

<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />


<cfoutput>
	<h1>#args.title#</h1>
	<div class="row">
		<div class="col-xs-12 col-md-8">
			
			#args.main_content#

			#renderForm(
				  formName            = "custom-forms.personal_details"
				, context             = "website"
				, formId              = "personal_details"
				, validationResult    = rc.validationResult ?: ""
				, includeValidationJs = true
				, fieldLayout         = "formcontrols.layouts.formfield.website"
			)#
			<div class="form-group">
				<input type="submit" value="Submit" class="btn">
			</div>


			#renderForm(
				  formName            = "custom-forms.account_info"
				, context             = "website"
				, formId              = "account_info"
				, validationResult    = rc.validationResult ?: ""
				, includeValidationJs = true
				, fieldLayout         = "formcontrols.layouts.formfield.website"
			)#
			<div class="form-group">
				<input type="submit" value="Submit" class="btn">
			</div>

		</div>
	</div>
</cfoutput>