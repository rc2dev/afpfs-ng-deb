#!/usr/bin/env bash

set -euo pipefail

readonly pkg_name="afpfs-ng"
readonly pkg_version="0.8.2"
readonly pkg_arch="$(dpkg-architecture -qDEB_BUILD_ARCH)"
readonly debian_codename="$(lsb_release -cs)"
readonly pkg_desc="Client for the Apple Filing Protocol"
readonly pkg_maintainer="Rafael Cavalcanti <dev@rafaelc.org>"
readonly pkg_depends="fuse"
readonly pkg_section="utils"
readonly pkg_priority="optional"

readonly repo_url="https://github.com/simonvetter/afpfs-ng"
readonly repo_commit="f6e24eb73c9283732c3b5d9cb101a1e2e4fade3e"
readonly repo_dir="/app/repo"
readonly build_dir="/app/build"
readonly dist_dir="/app/dist"


main() {
  prepare
  apply_patches
  build
  package
}

prepare() {
  mkdir -p "$repo_dir" 
  if [[ ! -d "$repo_dir"/.git ]]; then
    git clone --depth=1 "$repo_url" "$repo_dir"
  fi
  
  cd "$repo_dir"
  git checkout "$repo_commit"
}

apply_patches() {
  for patch in /app/patches/*.patch; do
    patch -p0 < $patch || true
  done
}

build() {
  mkdir -p "$build_dir" 
  rm -rf "$build_dir"/*

  cd "$repo_dir"
  ./configure --prefix="$build_dir"
  make -j"$(nproc)"
  make install
}

package() {
  mkdir -p "$dist_dir"

  local -r deb_name="${pkg_name}_${pkg_version}_${pkg_arch}_${debian_codename}"
  local -r deb_file="$dist_dir/$deb_name.deb"

  local -r pkg_root="/app/$deb_name"
  mkdir -p "$pkg_root/DEBIAN"
  mkdir -p "$pkg_root/usr"

  cp -a "$build_dir"/. "$pkg_root/usr/"

  cat > "$pkg_root/DEBIAN/control" <<EOF
Package: $pkg_name
Version: $pkg_version
Section: $pkg_section
Priority: $pkg_priority
Architecture: $pkg_arch
Depends: $pkg_depends
Maintainer: $pkg_maintainer
Description: $pkg_desc
EOF

  dpkg-deb --build "$pkg_root" "$deb_file"
}

main "$@"
