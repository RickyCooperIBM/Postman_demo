#!/bin/bash

echo "Checking for NPM"
echo "  Collection URL:  " $COLLECTION_URL

echo "Node Version:       " `node -v`
echo "NPM Version:        " `npm -v`
echo "Old Newman Version: " `newman --version`

echo "  Install newest newman version."
npm install newman newman-reporter-htmlextra --global --no-spin

echo "New Newman Version: " `newman --version`

mkdir testReports 
newman run $COLLECTION_URL --env-var trello_key=$TRELLO_KEY --env-var trello_token=$TRELLO_TOKEN --reporters cli,junit,htmlextra --reporter-junit-export "testReports/report.xml" --reporter-htmlextra-export  "testReports/report.html" -e $ENV_URL

echo "Complete!"