-- activate Finale
tell application id "sevs"
	try
		set theFinale to name of first process whose name begins with "Finale"
		tell process theFinale to set frontmost to true
	on error number -1719
		display dialog "Finale doesn't appear to be running."
		return
	end try
end tell