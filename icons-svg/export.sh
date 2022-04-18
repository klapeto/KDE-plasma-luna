#!/bin/bash
SIZES=(256 128 64 48 32)

FILE=$1

mkdir raster

for FILE in *.svg; do
  for SIZE in ${SIZES[*]}; do
    inkscape --export-png="./raster/${FILE%.svg}.${SIZE}x${SIZE}.png" --export-area-page --export-width=${SIZE} --export-height=${SIZE} --without-gui "${FILE}";
  done;
done
