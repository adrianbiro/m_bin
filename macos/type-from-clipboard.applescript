try
	set clipboardText to (the clipboard as text)
	
	if clipboardText is "" then
		display alert "Clipboard is empty." message "Copy the text you want to type and try again."
		return
	end if
	
	display dialog "Type Clipboard" & return & return & ¬
		"1. Click OK" & return & ¬
		"2. Click the destination field" & return & ¬
		¬
			"3. Clipboard contents will be typed after 3 seconds" buttons {"Cancel", "OK"} ¬
		default button ¬
		"OK" cancel button ¬
		"Cancel" with title "Type Clipboard"
	
	-- Time to click the destination field
	delay 3
	
	tell application "System Events"
		keystroke clipboardText
	end tell
	
on error errMsg number errNum
	if errNum is not -128 then
		display alert "Type Clipboard Error" message errMsg & " (" & errNum & ")"
	end if
end try