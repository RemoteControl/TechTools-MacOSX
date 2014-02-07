#!/usr/bin/env bash
# Bash skips errors and resumes by default

# Check if user is in AD domain.   
# If user is in domain and NOT in "SG_Policy_MacWriteLocal" AD group
# then mark local profile folders read-only
# also make sure folders are writable if membership changes

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
		chmod a+rxw /users/$USER/Documents
		chmod a+rxw /users/$USER/Movies
		chmod a+rxw /users/$USER/Music
		chmod a+rxw /users/$USER/Pictures
		chmod a+rxw /users/$USER/Downloads
		chmod a+rxw /users/$USER/Desktop
		chmod a+rxw /users/$USER/Public
	else
#		echo $vDateTimeMMDDHHMMSS $USER "is NOT in the SG_Policy_MacWriteLocal group, locking folders" >>$vLogFileOutput
		chmod a-rxw /users/$USER/Documents
		chmod a-rxw /users/$USER/Movies
		chmod a-rxw /users/$USER/Music
		chmod a-rxw /users/$USER/Pictures
		chmod a-rxw /users/$USER/Downloads
		chmod a-rxw /users/$USER/Desktop
		chmod a-rxw /users/$USER/Public
	fi
else
#		echo $vDateTimeMMDDHHMMSS $USER "is NOT in the domain, unlocking folders." >>$vLogFileOutput
 		chmod a+rxw /users/$USER/Documents
                chmod a+rxw /users/$USER/Movies
                chmod a+rxw /users/$USER/Music
                chmod a+rxw /users/$USER/Pictures
                chmod a+rxw /users/$USER/Downloads
                chmod a+rxw /users/$USER/Desktop
                chmod a+rxw /users/$USER/Public
fi
