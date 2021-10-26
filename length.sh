#!/bin/bash

VIDEO="$(realpath "$1")"
CRF=30

ffmpeg -y -i "$VIDEO" -vframes 1 -f image2 "$(basename -s '.mp4' "$VIDEO").jpg"
ffmpeg -y -i "$VIDEO" -tile-columns 1 -g 240 -threads 4 -quality good -crf $CRF -b:v 0 -c:v libvpx-vp9 -pass 1 -speed 4 -an -f null /dev/null && \
ffmpeg -y -i "$VIDEO" -tile-columns 1 -g 240 -threads 4 -quality good -crf $CRF -b:v 0 -c:v libvpx-vp9 -pass 2 -speed 1 -an "$(basename -s '.mp4' "$VIDEO").webm"
