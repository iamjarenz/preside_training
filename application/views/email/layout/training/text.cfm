<cfscript>
    param name="args.subject"          type="string" default="";
    param name="args.body"             type="string" default="";
    param name="args.read_online_link" type="string" default="";
</cfscript>

<cfoutput>
#Trim( args.body )#<cfif Len( Trim( args.read_online_link ) )>
View in browser: #args.read_online_link#</cfif>
</cfoutput>