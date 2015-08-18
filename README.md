mac-login-scripts
=================

Mac Login Scripts (helper scripts for using in school network)

There are currently 2 bash scripts and their associated PLIST file.  The script is run when a user logs in.

The scripts are:

  - home_folder_lock.sh - to prevent user from writing to certain folders on local machine.  used only when
                          Mac's are configured with AD logins that create local home directory but have the
                          networked home folder added to the dock.  PLEASE READ FILE FOR MORE INFORMATION.
  - untangle_logon.sh   - this is an adaptation of the scripts supplied by untangle.com for windows active
                          directory authentication integration.  PLEASE READ FILE FOR MORE INFORMATION.

  - reset_chrome.sh     - this script erases the local student/teacher Chrome support files to remove any user data
