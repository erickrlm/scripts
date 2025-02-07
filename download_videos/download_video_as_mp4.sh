#!/bin/bash

# Download a YouTube video using yt-dlp and make it mp4 w/ffmpeg.

# Validate URL input.  No need for quotes if we handle whitespace.
if [ -z "$1" ]; then
  echo "ERROR: Please provide a YouTube URL."
  exit 1
fi


# Sanitize filename
filename=$(yt-dlp --print-to-file filename "$1")  # Get suggested filename
filename="${filename%.*}" # Remove extension
filename="youtube-video" 


# Remove existing files with the same base name
if [ -f "$filename.webm" ]; then
  rm -f "$filename.webm"
  echo "Removed previous WebM file."
fi
if [ -f "$filename.mp4" ]; then
  rm -f "$filename.mp4"
  echo "Removed previous MP4 file."
fi


# Download video with specified name and preferred format
yt-dlp -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best "$1" -o "$filename.%(ext)s"

# Check if webm, then convert to mp4.
if [ -f "$filename.webm" ]; then
  ffmpeg -i "$filename.webm" "$filename.mp4" && rm -f "$filename.webm" # Convert and delete webm if successful
  echo "Converted to MP4 and removed WebM."
elif [ -f "$filename.mp4" ]; then
  echo "MP4 already downloaded. No conversion needed."
else
    echo "Error: No video file downloaded."
    exit 1
fi


echo "Download and processing complete."