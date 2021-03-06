<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>
	event_detail = queryRowToStruct(args.event_detail) ?: queryRowToStruct(queryNew(""));
	sessions = args.session ?: queryNew("");
	number_seats = ( prc.available_seats ?: 0 ) - ( prc.booked_seats ?: 0 );

	additionalArgs = {
    	  fields    = { 
    	  	  session={ labels=valueArray( sessions.label ), values=valueList(sessions.id) } 
    	  	, event_detail={ defaultValue=event_detail.ID }
    	  	, number_seats={ maxvalue= prc.available_seats != 0 ? number_seats : "" }
    	  }
    };


	event.include( assetId="js-eventbooking" );

</cfscript>

<cfoutput>
	<h1>#args.title# for "#event_detail.TITLE#"</h1>
	<div class="row">
		<div class="col-xs-12 col-md-8">


			<cfif rc.success ?: false >
				
				<cfif !isNull(rc.alertMessage)>
					<div class="alert #rc.alertClass ?: ""#">
						<p>#rc.alertMessage ?: ""#</p>				
					</div>
				</cfif>
				<p>Click here to return to <a href="#event.buildLink(page='homepage')#">homepage</a>.</p>			
			<cfelse>
				<cfif event.fullyBooked(event_detail.id) >
					<div class="alert alert-warning">
						<p>Event is fully booked. Please contact administrator.</p>				
					</div>

					<p>Click here to return to <a href="#event.buildLink(page='homepage')#">homepage</a>.</p>			

				<cfelse>
					<p>Price: #decimalFormat(event_detail.PRICE)#</p>
					
					#args.main_content#

					<cfif !isNull(rc.alertMessage)>
						<div class="alert #rc.alertClass ?: ""#">
							<p>#rc.alertMessage ?: ""#</p>				
						</div>
					</cfif>


					<form action="#event.buildLink( linkTo='page-types/event_booking_page.submit', queryString="ev=#rc.ev#" )#">
						#renderForm(
							  formName            = "event-booking.booking_details"
							, context             = "website"
							, formId              = "event_booking"
							, savedData           = rc.savedData  ?: {}
							, validationResult    = rc.validationResult ?: ""
							, includeValidationJs = true
							, additionalArgs      = additionalArgs
							, fieldLayout         = "formcontrols.layouts.formfield.website"
						)#
						<input type="hidden" name="ev" value="#rc.ev#">
						<input type="hidden" name="price" value="#event_detail.PRICE#">
						<div class="form-group">
							<input type="submit" value="Submit" class="btn">
						</div>
					</form>
				</cfif>
			</cfif>

			<hr>
			<a href="#event.buildLink( page='#event_detail.ID#')#">Return to event detail</a>
			<br>
			<br>

		</div>
	</div>



</cfoutput>