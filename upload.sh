#!/bin/sh

[ -e "LICENSE" ] || { echo "Please run this from the site repository's root directory."; exit 1 ;}
source ./config.sh
[ "$output_dir" ] || { echo "Couldn't load config.sh"; exit 1 ;}

./generate.sh

find "$output_dir" | xargs touch -r LICENSE
tar cv generated common | gzip -n > "$package_dir"/pages.tar.gz 
tar cv images publications | gzip -n > "$package_dir"/extras.tar.gz 
md5sum  "$package_dir"/pages.tar.gz >  "$package_dir"/pages.tar.gz.md5
md5sum  "$package_dir"/extras.tar.gz >  "$package_dir"/extras.tar.gz.md5

git add "$package_dir"/* && git commit && git push
