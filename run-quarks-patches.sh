#!/bin/bash

set -e

name="$1"
version="$2"
url="$3"
patches_dir=$(readlink -f "$4")
output_dir=$(readlink -f "$5")

echo "Will patch files for release '$name' with version '$version', from URL '$url'."
echo "Will consume patches from '$patches_dir' and the release tarball will be written in '$output_dir'."

# Download the release
wget -O "${output_dir}/${name}.tgz" "${url}"

# Use gunzip to unzip the tgz, and get the tar
gunzip -f "${output_dir}/${name}.tgz"
patches=$(find "${patches_dir}/${name}/${version}/" -type f)
mv "${output_dir}/${name}.tar" "${patches_dir}/${name}/${version}/"

pushd "${patches_dir}/${name}/${version}"
# Go through each patch file and add it to the tar
for p in $patches; do
  echo "Found patch '$p'"
  patched_file="${p/${patches_dir}\/${name}\/${version}\//}"
  echo "Patching $patched_file"
  tar -f  "${name}.tar" --delete "$patched_file"
  tar -uf "${name}.tar" "$patched_file"
done
popd

mv "${patches_dir}/${name}/${version}/${name}.tar" "${output_dir}/"

# Re-zip the tar
gzip -f "${output_dir}/${name}.tar"

echo "Succes"

