<cfscript>
	body     = renderView();
	mainNav  = renderViewlet( "core.navigation.mainNavigation" );
	metaTags = renderView( "/general/_pageMetaForHtmlHead" );
	adminBar = renderView( "/general/_adminToolbar"        );

	event.include( "css-bootstrap" )
	     .include( "css-layout"    )
	     .include( "js-bootstrap"  )
	     .include( "js-jquery"     );

	hideAddthis = getSystemSetting( category="addthis", setting="hide_addthis", default="false"  );
</cfscript>

<cfoutput><!DOCTYPE html>
<html>
	<head>
		#metaTags#

		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		#event.renderIncludes( "css" )#

		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>
	<body>
		<div class="container">
			<div class="header">
				<ul class="nav nav-pills pull-right">
					#mainNav#
				</ul>
				<h3 class="text-muted"><a href="/">Preside CMS</a></h3>
			</div>

			#body#

			<div class="footer">
				<p>&copy; Pixl8 2013-#Year( Now() )#</p>
			</div>
		</div>

		#adminBar#
		


		<cfif isEmptyString(hideAddthis)>
			<cfscript>
				addThisProfileId = getSystemSetting( category="addthis", setting="profile_id", default="ra-5a5c4c9cbfb3a849"  );
			</cfscript>

			<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js##pubid=#addThisProfileId#" async="async"></script>
		</cfif>

		#event.renderIncludes( "js" )#
	</body>
</html></cfoutput>