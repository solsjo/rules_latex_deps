#!/bin/bash

set -euxo pipefail

url="$1"
zip_file_path="$2"
file_name="$(basename $url)"
dir_name="$(echo $file_name | sed 's/\.tar\.gz//g')"
version="$(echo $file_name | sed 's/.*-\(.*\).tar.gz/\1/g')"

# Cleanup: remove temporary files
cleanup()
{
        local rc=$?
        trap - EXIT

        # Generally, it's the best to remove only the files that we
        # know that we have created ourselves. Removal using recursive
        # rm is not really safe.
        rm -f "$LOCAL_TMP/$file_name"
	rm -rf "$LOCAL_TMP/$dir_name"
        [ -d "$LOCAL_TMP" ] && rmdir "$LOCAL_TMP"

        exit $rc
}
trap cleanup HUP PIPE INT QUIT TERM EXIT

# Create a local temporary directory
LOCAL_TMP=$(mktemp -d "$version".XXXXXXX)

# Download
wget -nc "$url" -O "$LOCAL_TMP/$file_name"

# Extract
mkdir -p "$LOCAL_TMP/$dir_name"
tar -xf "$LOCAL_TMP/$file_name" -C "$LOCAL_TMP"

# Build
(\
cd "$LOCAL_TMP/$dir_name"; \
ls .; \
 \
autoreconf -fi; \
./configure; \
make so; \
\
)

# Zip
mkdir -p libgs
ls "$LOCAL_TMP/$dir_name"
ls "$LOCAL_TMP/$dir_name/sobin"
cp -R "$LOCAL_TMP/$dir_name/sobin/" ./libgs
zip "$zip_file_path" ./libgs/libgs.dylib
