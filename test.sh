#!/bin/sh
# Use this script to test the changes localy in your browser

[ -e "LICENSE" ] || { echo "Please run this from the site repository's root directory."; exit 1 ;}
source ./config.sh
[ "$output_dir" ] || { echo "Couldn't load config.sh"; exit 1 ;}

./generate.sh running || exit 1
mkdir -p "$publish_dir"
cp -R "$output_dir"/* "$common_dir"/* "${extras_data[@]}" "$publish_dir"
cd "$publish_dir" || exit 1
{ sleep 1; echo "Opening browser..."; xdg-open 'http://localhost:8000'; } &
python3 -m http.server
