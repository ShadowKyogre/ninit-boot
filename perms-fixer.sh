#!/bin/sh

# Corrects the permissions of any end, run, setup, etc. scripts that need executable flags
# Also corrects perms for things that really shouldn't have exec perms in here

find . -type f -name end -o -name run \
-name setup -o -name rsetup -o -name sys-rsetup \
-exec chmod -v a+x {} \;

find . -type f -not -name end -o -not -name run \
-not -name setup -o -not -name rsetup -o -not -name sys-rsetup \
-not -name "*.sh" -exec chmod -v a-x {} \;