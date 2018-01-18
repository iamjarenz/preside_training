<cfscript>
	body     = renderView();
	mainNav  = renderViewlet( "core.navigation.mainNavigation" );
	metaTags = renderView( "/general/_pageMetaForHtmlHead" );
	adminBar = renderView( "/general/_adminToolbar"        );

	event.include( "css-bootstrap" )
	     .include( "css-layout"    )
	     .include( "js-bootstrap"  )
	     .include( "js-jquery"     );

	hideAddthis     = getSystemSetting( category="addthis", setting="hide_addthis", default="false"  );
	disqusShortname = getSystemSetting( category="disqus",  setting="shortname",    default=""  );
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

		<cfif !isEmptyString(disqusShortname)>
			<script>

			/**
			*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
			*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/##configuration-variables*/
			/*
			var disqus_config = function () {
			this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
			this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
			};
			*/
			(function() { // DON'T EDIT BELOW THIS LINE
			var d = document, s = d.createElement('script');
			s.src = 'https://#disqusShortname#.disqus.com/embed.js';
			s.setAttribute('data-timestamp', +new Date());
			(d.head || d.body).appendChild(s);
			})();
			</script>
			<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
		</cfif>


		#event.renderIncludes( "js" )#
	</body>
</html></cfoutput>