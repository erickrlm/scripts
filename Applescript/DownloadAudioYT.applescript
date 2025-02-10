set videoURL to display dialog "Video URL (audio only):" default answer "" with icon note
set videoURL to text returned of videoURL

tell application "Terminal"
        activate
        do script "cd /Volumes/External/Music" in window 1
        do script "git commit -m " & quoted form of videoURL in window 1
        do script "yt-dlp -x --audio-format mp3 -o \"%(title)s.%(ext)s\" " & quoted form of videoURL in window 1
end tell