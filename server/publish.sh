#!/bin/bash -e

cd "$HOME"

source ./config.sh
[ "$publish_dir" ] || { echo "Couldn't load config.sh"; exit 1 ;}

# Make dirs absolute
staging_dir=$(readlink -f "$staging_dir")
download_dir=$(readlink -f "$download_dir")

download() {
   wget --no-check-certificate "$@"
}

fetch_file() {
   file="$1"
   [ -e "$file.md5" ] && mv "$file.md5" "$file.md5.prev"
   download "$package_url/$file.md5"
   diff "$file.md5.prev" "$file.md5" || {
      # If file has changed... 
      rm "$file"
      download "$package_url/$file"
      return 0
   }
   return 1
}

changes=0

mkdir -p "$download_dir"
cd "$download_dir"
if fetch_file pages.tar.gz
then
echo "pages..."
   rm -rf "${pages_data[@]}"
   tar zxvpf pages.tar.gz
   mv config.sh "$HOME"
   changes=1
fi
if fetch_file extras.tar.gz
then
echo "extras..."
   rm -rf "${extras_data[@]}"
   tar zxvpf extras.tar.gz
   changes=1
fi
cd ..

if [ "$changes" = 0 ]
then
   exit 0
fi

rm -rf "$staging_dir"
mkdir -p "$staging_dir"
cd "$download_dir"
cp -a "${extras_data[@]}" "$staging_dir"
cp -a "common/style.css" "$staging_dir"
cp -a "generated/"* "$staging_dir"
cd ..
rm -rf "$publish_dir"
mv "$staging_dir" "$publish_dir"

echo "Done!"

