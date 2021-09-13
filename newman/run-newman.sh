#!/bin/bash

echo "Checking for NPM"
echo "  Collection URL:  " $COLLECTION_URL

echo "Node Version:       " `node -v`
echo "NPM Version:        " `npm -v`
echo "Old Newman Version: " `newman --version`

echo "  Install newest newman version."
npm install newman newman-reporter-htmlextra --global --no-spin

echo "New Newman Version: " `newman --version`

# using the v3 syntax.
echo "$COLLECTION_URL"
echo "$TRELLO_TOKEN"
echo "$TRELLO_KEY"

mkdir testReports 
newman run $COLLECTION_URL --global-var trello_key=$TRELLO_KEY --global-var trello_token=$TRELLO_TOKEN --reporters cli,junit,htmlextra --reporter-junit-export "testReports/report.xml" --reporter-htmlextra-export  "testReports/report.html" 

echo "Complete!"