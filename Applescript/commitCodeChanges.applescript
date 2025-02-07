tell application "Terminal"
	activate
	set theText to display dialog "Enter some text:" default answer "Local Update via Applescript" with icon note
	set theText to text returned of theText
	
	tell application "Terminal"
		activate
		do script "git add ." in window 1
		do script "git commit -m \"" & quoted form of theText & "\"" in window 1
		do script "git push origin main" in window 1
	end tell
end tell