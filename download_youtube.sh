#!/bin/bash
# Download a Youtube video using ffmpeg and yt-dlp for editing


# Check quotes on URL input
if [ -z "$1" ]
then
      echo "ERROR: Add single quotes to the video URL."
      exit 1
fi

# Loop through the list of files and delete any files that contain the string "youtube" in their name.
files=$(ls)

for file in $files; do
  if [[ $file =~ "youtube-video." ]]; then
    rm -f $file
    echo "Removed previous file"
  fi
done

# Download video with specific name
yt-dlp $1 --output "youtube-video.%(ext)s"

# Check file extension for WebM files and Convert from WebM to mp4 if necessary
ffmpeg -i youtube-video.webm youtube-video.mp4 || echo "File conversion not necessary"

# Delete the WebM file if exists
rm -f ./youtube-video.webm || true