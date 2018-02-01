component {
	private struct function prepareParameters( required struct member_details, required string display_name, required string login_id ) {


		return {
			  display_name = arguments.display_name
			, login_id     = arguments.login_id
			, details      = {
				  html = trim( renderView( view = "/email/template/memberConfirmation/_detailsHtml", args = member_details ) )
				, text = trim( renderView( view = "/email/template/memberConfirmation/_detailsText", args = member_details ) )
			}
		};
	}

	private struct function getPreviewParameters() {

		return {
			  display_name = "John Smith"
			, login_id     = "john_smith"
			, details   = {
				  html = trim( renderView( view = "/email/template/memberConfirmation/_detailsHtml", args = _getPreviewDetails() ) )
				, text = trim( renderView( view = "/email/template/memberConfirmation/_detailsText", args = _getPreviewDetails() ) )
			}
		};
	}



	private struct function _getPreviewDetails(){
		return {
			personal = {
				  firstname              = "John"
				, lastname               = "Smith"
				, email                  = "john@smith.com"
				, gender                 = "Male"
				, dob                    = dateAdd( "yyyy", -40, now() )
				, address                = "Lipa City, Batangas"
			}
			, interests   = "Bike,Gadgets,Outdoor"
		};
	}


	private string function defaultSubject() {
		return "Membership Confirmation";
	}

	private string function defaultHtmlBody() {
		return renderView( view="/email/template/memberConfirmation/defaultHtmlBody" );
	}

	private string function defaultTextBody() {
		return renderView( view="/email/template/memberConfirmation/defaultTextBody" );
	}

}