site
====

LabLua website


How to update the website
=========================

1. Edit the files in the edit\_here directory
2. Run ./test.sh to test the changes locally.
3. Run ./upload.sh to commit the changes and upload them
4. Wait up to 24h for the changes to appear on www.lua.inf.puc-rio.br

The obalue.inf.puc-rio webserver has a cron job that runs once per day (soon after midnight) to update the website.
It downloads the tar.gz files from this Github repo and unpacks them in the appropriate place.
It is important that you use the upload.sh script to create your commits, because that script also updates the tar.gz files.
