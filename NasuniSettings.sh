#!/bin/bash

# Casper PlistBuddy script to disable icon previews and the preview pane for enhanced
# SMB share compatibility.  Should work with 10.9 through 10.11 (and beyond?)
#
# June 2016 - Neil Broadbent - Proactis Solutions - www.proactis.net
#
#
# This script elaborates on some brilliant work from gumptiontech at the following link:
# http://gumptiontech.co.uk/2015/06/17/disable-mac-10-9-finder-thumbnail-preview-by-command/
#
# I've modified it to run as root and act on the currently logged in user.  Also added
# additional lines to shut off the preview column in the column finder view, and to
# disable .DS_Store creation on SMB shares.
#
# This should be run at user login, or by any other means while the target user is logged in.


# Define variables for plistbuddy path, current user, and destination file path
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
plistbuddy=/usr/libexec/PlistBuddy
plistfile=/Users/$loggedInUser/Library/Preferences/com.apple.finder.plist

# Delete the existing cover-flow preview setting
$plistbuddy -c 'Delete StandardViewSettings:ExtendedListViewSettings:showIconPreview' $plistfile;

# Delete the existing icon preview setting
$plistbuddy -c 'Delete StandardViewSettings:IconViewSettings:showIconPreview' $plistfile;

# Delete the existing list icon preview setting
$plistbuddy -c 'Delete StandardViewSettings:ListViewSettings:showIconPreview' $plistfile;

# Delete the existing column icon preview setting
$plistbuddy -c 'Delete StandardViewOptions:ColumnViewOptions:ShowIconThumbnails' $plistfile;

# Delete the existing column preview column setting
$plistbuddy -c 'Delete StandardViewOptions:ColumnViewOptions:ColumnShowIcons' $plistfile;

# Reset the cover-flow preview setting to off
$plistbuddy -c 'Add StandardViewSettings:ExtendedListViewSettings:showIconPreview bool false' $plistfile;

# Reset the icon preview setting to off
$plistbuddy -c 'Add StandardViewSettings:IconViewSettings:showIconPreview bool false' $plistfile;

# Reset the list icon preview setting to off
$plistbuddy -c 'Add StandardViewSettings:ListViewSettings:showIconPreview bool false' $plistfile;

# Reset the column icon preview setting to off
$plistbuddy -c 'Add StandardViewOptions:ColumnViewOptions:ShowIconThumbnails bool false' $plistfile;

# Reset the column preview column setting to off
$plistbuddy -c 'Add StandardViewOptions:ColumnViewOptions:ColumnShowIcons bool false' $plistfile;

# Repair ownership on plist file
chown -R "$loggedInUser:staff" $plistfile

# Note that existing .DS_Store files on an SMB share may override these defaults.
# A cleanup of existing .DS_Store files in conjunction with the following lines may
# yield better results.  Comment the following three lines if undesired.
dsstore=/Users/$loggedInUser/Library/Preferences/com.apple.desktopservices.plist
defaults write $dsstore DSDontWriteNetworkStores true
chown -R "$loggedInUser:staff" /Users/$loggedInUser/Library/Preferences/com.apple.desktopservices.plist

# Delete prefs/plist cache
killall cfprefsd

# Restart the Finder
killall Finder
