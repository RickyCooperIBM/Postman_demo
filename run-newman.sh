#!/bin/bash

echo "Checking for NPM"
echo "  Collection URL:  " $COLLECTION_URL

echo "Node Version:       " `node -v`
echo "NPM Version:        " `npm -v`
echo "Old Newman Version: " `newman --version`

echo "  Install newest newman version."
ls
npm install newman newman-reporter-htmlextra --global --no-spin

echo "New Newman Version: " `newman --version`

mkdir testReports 
newman run $COLLECTION_URL --env-var TRELLO_KEY=$TRELLO_KEY --env-var TRELLO_TOKEN=$TRELLO_TOKEN --reporters cli,junit,htmlextra --reporter-junit-export "testReports/report.xml" --reporter-htmlextra-export  "testReports/report.html" -e $ENV_URL
