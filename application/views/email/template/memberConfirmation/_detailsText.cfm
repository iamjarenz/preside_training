<cfscript>

</cfscript>

<cfoutput>
	<cfif !isEmpty( args )>

=================================
Application details
=================================

First Name: #( args.personal.firstname ?: "" )#
Last Name: #( args.personal.lastname ?: "" )#
Gender: #( args.personal.gender ?: "" )#
Date of birth: #dateFormat( args.personal.dob, "dd-mmm-yyyy" )#
Email address: #( args.personal.email ?: "" )#
<cfif len( args.personal.address ?: "" )>Address: #args.personal.address#</cfif>
<cfif len( args.interests ?: "" )>Interests: #replace( args.interests, ",", ", ", "all" )#</cfif>

	</cfif>
</cfoutput>