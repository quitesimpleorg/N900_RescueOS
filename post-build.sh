#!/bin/bash

set -e

target="$1"

delfiles=" \
  $target/etc/init.d/rcK \
  $target/etc/init.d/S20urandom \
  $target/etc/init.d/S40network \
  $target/etc/securetty"
for file in $delfiles ; do 
  [ -e "$file" ] && rm "$file" || true
done
