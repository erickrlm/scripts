-- Set programming environment by opening a selected list of apps 
-- arranged with Rectangle app

-- Open VS Code and set it at right side of the screen
tell application "Visual Studio Code"
	activate
	delay 1
	tell application "System Events"
		key code 124 using {control down, option down}
	end tell
end tell

-- Open Safari, go to Gemini Ai and set it at top left of screen
tell application "Safari"
	activate
	delay 1
	open location "https://gemini.google.com"
	tell application "System Events"
		keystroke "u" using {control down, option down}
	end tell
end tell

-- Open the Terminal and go to the developer folder
tell application "Terminal"
	activate
	do script "cd /Users/erick/Developer" in window 1
	delay 1
	tell application "System Events"
		keystroke "j" using {control down, option down}
	end tell
end tell