#!/bin/bash

[ "$1" = "running" ] || {
   echo "Do not launch this one directly. Use ./upload.sh instead."
   exit 1
}

source ./config.sh
[ "$output_dir" ] || { echo "Couldn't load config.sh"; exit 1 ;}

root_dir="$PWD"

# Make paths absolute
pages_dir=$(readlink -f "$pages_dir")
output_dir=$(readlink -f "$output_dir")
common_dir=$(readlink -f "$common_dir")

# Reset output dir
rm -rf "$output_dir"
mkdir -p "$output_dir"

cd "$pages_dir"
find . -type f | while read file
do
   file_dir=$(dirname "$file")
   mkdir -p "$output_dir/$file_dir"
   output_file="$output_dir/$file"
   echo "<!-- THIS FILE WAS AUTOMATICALLY GENERATED. -->" > "$output_file"
   cat "$common_dir/header.html" $file "$common_dir/footer.html" |\
     sed -e 's/á/\&aacute;/g' \
         -e 's/é/\&eacute;/g' \
         -e 's/í/\&iacute;/g' \
         -e 's/ó/\&oacute;/g' \
         -e 's/ú/\&uacute;/g' \
         -e 's/à/\&agrave;/g' \
         -e 's/â/\&acirc;/g'  \
         -e 's/ê/\&ecirc;/g'  \
         -e 's/ô/\&ocirc;/g'  \
         -e 's/ã/\&atilde;/g' \
         -e 's/õ/\&otilde;/g' \
         -e 's/ç/\&ccedil;/g' \
     >> "$output_file"
done
