#!/bin/bash

# Download a list of videos from a simple txt file when using sites without playlist support

# Set delay time in seconds
DELAY_SECONDS=5

# Check if the file with the URLS exists
if [ ! -f "urls.txt" ]; then
    echo "Error: urls.txt file not found."
    exit 1
fi

# Read and print with sanitization and delay
while IFS= read -r url || [ -n "$url" ]; do
    # Sanitize the URL (example: remove leading/trailing whitespace)
    sanitized_url=$(echo "$url" | tr -d '\r' | xargs)
    
  # Check if the sanitized URL is empty (e.g., after removing only whitespace lines)
    if [ -n "$sanitized_url" ]; then # -n checks for non-zero length
        yt-dlp "$sanitized_url"
    fi

    # Add delay unless it's the last line
    if [ -n "$url" ]; then
        sleep $DELAY_SECONDS
    fi
done < urls.txt

echo "Finished processing urls.txt"