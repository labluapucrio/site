#!/bin/sh

pages_dir=edit_here
output_dir=generated
common_dir=common
package_dir=packed
pages_data=(generated common)
extras_data=(images publications)

# server side configuration:
publish_dir=public_html
staging_dir="$publish_dir.new"
server_url=https://github.com/labluapucrio/site/raw/master
package_url="$server_url/$package_dir"

