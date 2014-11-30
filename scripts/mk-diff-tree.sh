#!/bin/bash

export LC_ALL=C

diff -durq "../archives/$1" "$1" | while read -a line; do
  case "${line[0]}" in
    "Files")
      orig="${line[1]}"
      file="${line[3]}"
      dir="../patches/$(dirname $file)"
      patch="${dir}/$(basename ${file}).diff"
      echo "${orig} vs. ${file} -> ${patch}"
      mkdir -p "${dir}"
      diff -du "${orig}" "${file}" | sed -e "s,--- ../archives/$1,--- $1," >"${patch}"
      ;;
    "Only")
      file="${line[2]%:}/${line[3]}"
      dir="../patches/${line[2]%:}"
      if ! [[ "${file}" =~ ~$ ]]; then
        mkdir -p "${dir}"
        cp -v "${file}" "${dir}/"
      fi
      ;;
    *)
      ;;
  esac
done
