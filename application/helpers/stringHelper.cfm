<cffunction name="stripHTML" access="public" returntype="string">
	<cfargument name="stringContent" type="string"  required="true" />

	<cfscript>
		return REReplaceNoCase(arguments.stringContent, "<[^[:space:]][^>]*>", "", "ALL");
	</cfscript>
</cffunction>