#!/usr/bin/env bash
# Bash skips errors and resumes by default

# Time in seconds to sleep between request
SLEEP_PERIOD=300

# log file
#LOGFILE="/var/log/untangle_script_log.txt"

# Lets define the protocol to be used.
URL_PREFIX="http"

# Determine if different ip provided in command line argument
if [ $# -eq 1 ]; then
  SERVERNAME="$1"
else
  SERVERNAME="10.1.0.1"
fi

# Take out the comments below for testing the script
# echo "ServerName is:"
# echo $SERVERNAME

# log any current user out of the Captive Portal (not Directory Connector)
curl --location http://10.1.0.1/capture/logout

# set strUSER to current user
strUser=$USER
# if ["$(USER)" == 'sscpslocal']; then
#   strUser=joeadmin
# else
#   strUser=$USER
# fi
 strDomain=AD
 strHostname=$(hostname -s)

# This should "overwrite" any active Directory Connector credentials
# Execute script until successful
while true; do
     URLCOMMAND=${URL_PREFIX}"://"${SERVERNAME}"/adpb/registration?username="${strUser}"&domain="${strDomain}"&hostname="${strHostname}"&action=login"

     # Take out the comments below for testing the urlcommand
     # curl arguments: -f fails silently, -s silent mode with no progress status, -m maximum execution time allowed
     curl -f -s -m 10 $URLCOMMAND
     sleep $SLEEP_PERIOD
done
