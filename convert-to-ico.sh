#!/bin/bash
mkdir raster
mkdir ico


#SIZES=(256 128 64 48 32 24 20 16)

#FILE=$1

#for FILE in *.svg; do
#  for SIZE in ${SIZES[*]}; do
#    inkscape -w ${SIZE} -h ${SIZE} -o ./raster/${SIZE}.png $FILE
#  done;
#  convert ./raster/16.png ./raster/20.png ./raster/24.png ./raster/32.png ./raster/48.png ./raster/64.png ./raster/256.png ./ico/$1.ico
#done



inkscape -w 16 -h 16 -o ./raster/16.png $1
inkscape -w 20 -h 20 -o ./raster/20.png $1
inkscape -w 24 -h 24 -o ./raster/24.png $1
inkscape -w 32 -h 32 -o ./raster/32.png $1
inkscape -w 48 -h 48 -o ./raster/48.png $1
inkscape -w 64 -h 64 -o ./raster/64.png $1
inkscape -w 256 -h 256 -o ./raster/256.png $1
convert ./raster/16.png ./raster/20.png ./raster/24.png ./raster/32.png ./raster/48.png ./raster/64.png ./raster/256.png ./ico/$1.ico
rm -rf raster
