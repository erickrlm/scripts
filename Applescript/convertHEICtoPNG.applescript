use scripting additions

-- Convert function
on convertHEICtoPNG(HEICPath, PNGPath)
	try
		set theImage to POSIX file HEICPath as alias
		set thePNGFile to POSIX file PNGPath
		
		-- Use sips (System Image Processing System) for conversion
		do shell script "/usr/bin/sips -s format png " & quoted form of POSIX path of theImage & " -o " & quoted form of POSIX path of thePNGFile
		
		return true
		
	on error errorMessage
		return errorMessage
	end try
end convertHEICtoPNG


-- Ask user to select source image and destination path
set heicFile to POSIX path of (choose file with prompt "Select HEIC image:")
set pngFile to POSIX path of (choose file name with prompt "Save PNG as:" default name "converted.png")

set conversionResult to convertHEICtoPNG(heicFile, pngFile)

if conversionResult is true then
        display dialog "HEIC to PNG conversion successful!"
else
        display dialog "Error: " & conversionResult
end if