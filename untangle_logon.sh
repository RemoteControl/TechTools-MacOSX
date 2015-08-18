#!/usr/bin/env bash
# Bash skips errors and resumes by default

# This script is based on the ad_login.vb script provided by untangle.com.  

# Time in seconds to sleep between requests
SLEEP_PERIOD=300

# Lets define the protocol to be used.
URL_PREFIX="http"

# Determine if different ip provided in command line argument
if [ $# -eq 1 ]; then
  SERVERNAME="$1"
else
  SERVERNAME="10.1.0.1"
fi

# log any previous user to system out of the Captive Portal (not Directory Connector)
curl --location http://10.1.0.1/capture/logout

# set strUSER to current user
strUser=$USER
strDomain=AD
strHostname=$(hostname -s)

# This should "overwrite" any active Directory Connector credentials
# Execute script until logout
while true; do
     URLCOMMAND=${URL_PREFIX}"://"${SERVERNAME}"/userapi/registration?username="${strUser}"&domain="${strDomain}"&hostname="${strHostname}"&action=login""&secretKey=jRMbLjkTZos"

     # Take out the comments below for testing the urlcommand
     # curl arguments: -f fails silently, -s silent mode with no progress status, -m maximum execution time allowed
     curl -f -s -m 10 $URLCOMMAND
     sleep $SLEEP_PERIOD
done
