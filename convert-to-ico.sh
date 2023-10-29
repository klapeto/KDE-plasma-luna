#!/bin/bash
mkdir raster

SIZES=(256 128 64 48 32 24 22 16)

FILE=$1

for SIZE in ${SIZES[*]}; do
  inkscape -w ${SIZE} -h ${SIZE} -o ./raster/${SIZE}.png $FILE
done;

