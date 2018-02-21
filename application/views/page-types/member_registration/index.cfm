<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />


<cfoutput>
	<h1>#args.title#</h1>
	<div class="row">
		<div class="col-xs-12 col-md-8">
			
			#args.main_content#

			<cfif !isNull(rc.alertMessage)>
				<div class="alert #rc.alertClass ?: ""#">
					<p>#rc.alertMessage ?: ""#</p>				
				</div>
			</cfif>

			<cfif rc.success ?: false >

				<cfif event.isUKMember( rc.savedData.country ?: "" )>
					<p><strong>For UK Members only:</strong> You get a promotinal pacakge for registring! Yaaaay!</p>
				</cfif>

				<p>Click here to return to <a href="#event.buildLink(page='homepage')#">homepage</a>.</p>			
			<cfelse>

				<form action="#event.buildLink( linkTo='page-types/member_registration.submit' )#">
					#renderForm(
						  formName            = "registration.user_details"
						, context             = "website"
						, formId              = "registration"
						, savedData           = rc.savedData  ?: {}
						, validationResult    = rc.validationResult ?: ""
						, includeValidationJs = true
						, fieldLayout         = "formcontrols.layouts.formfield.website"
					)#
					<div class="form-group">
						<input type="submit" value="Submit" class="btn">
					</div>
				</form>
				
			</cfif>

		</div>
	</div>
</cfoutput>