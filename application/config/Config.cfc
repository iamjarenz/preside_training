component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "training_admin";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "training";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "training";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;

		_setupDerivatives( settings.assetmanager.derivatives );


	}


	private void function _setupDerivatives( required struct derivatives ) {

		derivatives.leadImage = {
		      permissions     = "inherit"
		    , inEditor        = true
		    , transformations = [ { 
		    	  method = "resize"
		    	, args   = { width=770, height=400, maintainAspectRatio=true } 
		    } ]
		};
		derivatives.detailImage = {
		      permissions     = "inherit"
		    , inEditor        = true
		    , transformations = [ { 
		    	  method = "shrinkToFit"
		    	, args   = { width=770, height=400 } 
		    } ]
		};
	}
}
