#!/bin/bash

# Download a YouTube video using yt-dlp and ffmpeg.

# Validate URL input.  No need for quotes if we handle whitespace.
if [ -z "$1" ]; then
  echo "ERROR: Please provide a YouTube URL."
  exit 1
fi

# Sanitize filename (more robust).  Use yt-dlp's built-in features!
filename=$(yt-dlp --print-to-file filename "$1")  # Get suggested filename
filename="${filename%.*}" # Remove extension. We'll handle it ourselves.
filename="youtube-video"  # Our base name

# Remove existing files with the same base name (more targeted).
# Avoid ls in loops!
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

# Conversion logic:  Check if we downloaded webm, then convert.
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