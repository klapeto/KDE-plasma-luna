#!/bin/bash
mkdir raster

SIZES=(512 256 128 96 64 48 32 24 22 16)

FILE=$1
SUB=$2

for SIZE in ${SIZES[*]}; do
  inkscape -w ${SIZE} -h ${SIZE} -o ./home/dot-local/icons/Luna/${SIZE}x${SIZE}/${SUB}.png $FILE
done;

