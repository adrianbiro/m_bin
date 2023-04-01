#!/bin/bash
# Set the IFS variable to the newline character will stop word splitting.
# This will only do a split at newlines and spaces will remain.
IFS='
'
# Turn off globing
set -f
for i in $(find . -name "*[.m4a | .mp4]"); do
  name="${i%.*}"
  ffmpeg -i "${i}" -b:a 192K -vn "${name}.mp3" &
done

# The ffmpeg output is pretty verbose, but in bulk
# and in the background it is useless.
# This keeps track of jobs in a more manageable way.
while :; do
  jobs
  sleep 5
  if [[ $(jobs -l | wc -l) == 0 ]]; then
    break
  fi
done

echo "Done"

# Keep in mind it is resources hungry and it take a time
# to proces large files.
# If reasource are constraint just remove ampersant '&'
# and comment out while loop.
