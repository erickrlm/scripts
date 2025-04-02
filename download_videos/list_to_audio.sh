
filename=urls.txt
DELAY_SECONDS=5

# Check if the URL file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

# Loop through each line of the file and print it
while IFS= read -r url || [ -n "$url" ]; do

    # Sanitize the URL (example: remove leading/trailing whitespace)
    sanitized_url=$(echo "$url" | tr -d '\r' | xargs)

    yt-dlp -x --audio-format mp3 -o \"%\(title\)s.%\(ext\)s\" "$sanitized_url"

    # Add delay unless it's the last line
    if [ -n "$url" ]; then
        sleep $DELAY_SECONDS
    fi

done < "$filename"

exit 0