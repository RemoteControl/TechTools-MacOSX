#!/usr/bin/env bash
# Bash skips errors and resumes by default

# Check if user is in AD groups of "Domain Users" and "SG_Policy_MacWriteLocal".
# The idea is that Domain Users should only write to networked path, unless they
# have permission to write locally.  This is helpful for students or non-techie
# faculty and staff.

# Literal logic:
# If user is in both AD groups, sets specific directories to u+rwX.
#    This is done in case the membership of "SG_Policy_MacWriteLocal" changed.  
# If the user is then a member of "Domain Users", but not SG group, sets specific directories to a-rwX.
#    This prevents them from leaving files on local machine since they are not assigned to individuals.
# If the users is no in "Domain Users", sets specific directories to u+rwX.
#    This is standard Mac OS X permissions.  Done mostly in case local user is created with same name
#    as domain users.
# The instances where they are not in "Domain Users" but in SG group should not exist.  

# Logging setup
# vLogFileName="folder_lock.log"
# vLogPath="/Library/Logs/FolderLockLog/"

# vDateTimeMonth=`date +%m`
# vDateTimeDay=`date +%d`
# vDateTimeHour=`date +%H`
# vDateTimeMin=`date +%M`
# vDateTimeSec=`date +%S`
# vDateTimeMMDDHHMMSS=$vDateTimeMonth"/"$vDateTimeDay" #"$vDateTimeHour":"$vDateTimeMin":"$vDateTimeSec

# vLogFileOutput=$vLogPath$vLogFileName

groups=$(id -Gn $USER)

if [[ $groups =~ "Domain Users" ]]; then
#	echo $vDateTimeMMDDHHMMSS $USER "is in the domain" >>$vLogFileOutput
	if [[ $groups =~ "SG_Policy_MacWriteLocal" ]]; then
#		echo $vDateTimeMMDDHHMMSS $USER "is in SG_Policy_MacWriteLocal group, unlocking folders" >>$vLogFileOutput
		chmod u+rwX /users/$USER/Documents
		chmod u+rwX /users/$USER/Movies
		chmod u+rwX /users/$USER/Music
		chmod u+rwX /users/$USER/Pictures
		chmod u+rwX /users/$USER/Downloads
		chmod u+rwX /users/$USER/Desktop
		chmod u+rwX /users/$USER/Public
	else
#		echo $vDateTimeMMDDHHMMSS $USER "is NOT in the SG_Policy_MacWriteLocal group, locking folders" >>$vLogFileOutput
		chmod a-rwX /users/$USER/Documents
		chmod a-rwX /users/$USER/Movies
		chmod a-rwX /users/$USER/Music
		chmod a-rwX /users/$USER/Pictures
		chmod a-rwX /users/$USER/Downloads
		chmod a-rwX /users/$USER/Desktop
		chmod a-rwX /users/$USER/Public
	fi

# Mount local folders to network location
# The dscl command returns "dsAttrTypeNative:homeDirectory: <full AD home folder path>
# awk parses this and makes its own space seperated variables
# so "dsAttrTypeNative:homeDirectory:" is $1 and i.e. "\\ROWLEY\FacStaffUserFiles$\jmcsheffrey" is $2, so we print $2

	vHomeFolder=$( dscl "/Active Directory/AD/All Domains" -read /Users/$USER dsAttrTypeNative:homeDirectory | awk '{print $2}' )

	mount -t smbfs $vHomeFolder/Documents ~/Documents
	mount -t smbfs $vHomeFolder/Movies ~/Movies
	mount -t smbfs $vHomeFolder/Music ~/Music
	mount -t smbfs $vHomeFolder/Pictures ~/Pictures
	mount -t smbfs $vHomeFolder/Downloads ~/Downloads
	mount -t smbfs $vHomeFolder/Desktop ~/Desktop
	mount -t smbfs $vHomeFolder/Public ~/Public
	
else
#		echo $vDateTimeMMDDHHMMSS $USER "is NOT in the domain, unlocking folders." >>$vLogFileOutput
 		chmod u+rwX /users/$USER/Documents
                chmod u+rwX /users/$USER/Movies
                chmod u+rwX /users/$USER/Music
                chmod u+rwX /users/$USER/Pictures
                chmod u+rwX /users/$USER/Downloads
                chmod u+rwX /users/$USER/Desktop
                chmod u+rwX /users/$USER/Public
fi


