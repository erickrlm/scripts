#!/bin/bash

# Get the YouTube URL from the user.
read -p "Enter YouTube URL: " youtube_url

# Check if the URL is empty.
if [ -z "$youtube_url" ]; then
  echo "Error: YouTube URL is required."
  exit 1
fi

# Extract the video title (for filename).
video_title=$(yt-dlp --get-title "$youtube_url")

# Sanitize the video title to create a safe filename (remove special characters).
# This is a basic sanitization.  You might want to add more characters as needed.
safe_title=$(echo "$video_title" | tr -cd '[:alnum:][:space:]_' | sed 's/ //g') #Alphanumeric, space and underscore

# Create the output filename (mp4).
output_filename="$safe_title.mp4"

# Download the audio only in mp4 format.
yt-dlp -f bestaudio[ext=m4a]/bestaudio/mp4 --extract-audio --audio-format mp4 -o "$output_filename" "$youtube_url"

# Check for download errors (yt-dlp exit code).
if [ $? -ne 0 ]; then
  echo "Error: Audio download failed."
  exit 1
fi

echo "Audio downloaded successfully as '$output_filename'."

exit 0