#!/bin/bash

## Script to rewrite the Favorite Server List in OSX 10.12.5
## Written 7/12/17 by Ethanos

## Delete the old preferences file

rm ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.FavoriteServers.sfl

## Restart Finder

killall cfprefsd
killall sharedfilelistd
killall Finder

## Recreate the list and add the following items

## For additional shares, remove the comment and use the format below
## sfltool add-item -n "Name" com.apple.LSSharedFileList.FavoriteServers "URL"

sfltool add-item -n "HX Server" com.apple.LSSharedFileList.FavoriteServers "smb://hxserver.corp.concentrichx.com"

## sfltool add-item -n "Transfer" com.apple.LSSharedFileList.FavoriteServers "afp://10.5.0.241"
