-- Select a running process (sorted), confirm, then restart it

-- 1) Build a sorted list of running processes (names)
tell application "System Events"
	set procNames to name of every process
end tell

set procNames to my uniqueList(procNames)
set procNames to my sortList(procNames)

-- 2) Scrollable selection UI
set chosen to choose from list procNames with title "Running Processes (Sorted)" with prompt "Select a process/app to restart:" OK button name "Restart…" cancel button name "Cancel"

if chosen is false then return
set appName to item 1 of chosen

-- 3) Confirmation dialog BEFORE restarting
set msg to "Restart process/app:" & return & return & appName & return & return & "This will try to quit it cleanly. If it does not exit, it will be force-killed."
set btn to button returned of (display dialog msg buttons {"Cancel", "Restart"} default button "Restart" cancel button "Cancel" with icon caution)

if btn is not "Restart" then return

-- 4) Restart selected
restartApp(appName)

display dialog "Done." & return & "Restart attempted for: " & appName buttons {"OK"} default button "OK"

--------------------------------------------------------------------------------
-- Restart handler (your logic + minor hardening)
--------------------------------------------------------------------------------
on restartApp(appName)
	tell application "System Events"
		set isRunning to (exists process appName)
	end tell
	
	if isRunning then
		-- Try graceful quit
		try
			tell application appName to quit
		end try
		
		-- Wait up to ~6 seconds for it to exit
		repeat with i from 1 to 30
			tell application "System Events"
				if not (exists process appName) then exit repeat
			end tell
			delay 0.2
		end repeat
		
		-- If still running, kill it
		tell application "System Events"
			if exists process appName then
				try
					do shell script "pkill -x " & quoted form of appName
				end try
			end if
		end tell
	end if
	
	-- Optional relaunch:
	-- Some apps relaunch via activate, but others may not.
	-- For GlobalProtect you mentioned it auto-starts, so keeping it commented.
	(*
    try
        tell application appName to activate
    end try
    *)
end restartApp

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
on uniqueList(theList)
	set outList to {}
	repeat with i in theList
		set v to i as text
		if outList does not contain v then set end of outList to v
	end repeat
	return outList
end uniqueList

on sortList(theList)
	set AppleScript's text item delimiters to linefeed
	set joined to theList as text
	set AppleScript's text item delimiters to ""
	
	set sortedText to do shell script "printf '%s
' " & quoted form of joined & " | tr '\\r' '\\n' | LC_ALL=C sort -f"
	if sortedText is "" then return {}
	return paragraphs of sortedText
end sortList
