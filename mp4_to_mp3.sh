#!/bin/bash
mp4_files=$(ls -1 . | grep '[.m4a | .mp4]$')

for i in $mp4_files
do
  name="${i%.*}"
  ffmpeg -i "${i}" -b:a 192K -vn "${name}.mp3"
done
