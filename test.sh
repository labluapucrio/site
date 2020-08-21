#!/bin/sh
# Use this script to test the changes localy in your browser

./generate.sh running || exit 1
mkdir -p testdir
cp -R generated/* common/* images testdir
cd testdir || exit 1
{ sleep 1; echo "Opening browser..."; xdg-open 'http://localhost:8000'; } &
python3 -m http.server
