changesSaved()
{
	SplashTextOn, 400,80, , The Changes Saved.  Script restarting...
	Sleep, 1500
	SplashTextOff
	Reload
}

Current_Tab()
{
	GuiControlGet,Current_Tab,,TabGroup
	return Current_Tab
}

ultimatum(functionToPerform)
{
	MsgBox,5,Error,Couldn't find the right things.`nPress Retry or Cancel to reload the script
	IfMsgBox Retry
		%functionToPerform%(dummy1,dummy2,dummy3)
	Else
		IfMsgBox Cancel
		{
			Reload
			Sleep 1000 
			MsgBox, Sorry.  Couldn't reload the script.
			return
		}
}

; activate Finale
goToFinale()
{
	WinActivate, Finale 
	WinWaitActive, Finale
}

waitForCursorToGoFromHourGlassToArrow()
{	
	timeOutCounter:=0
	while ((A_cursor != "Wait") && (timeOutCounter < 1000))
	{
		sleep 10
		timeOutCounter++
	}
	while ((A_cursor = "Wait") && (timeOutCounter < 1000))
	{
		sleep 10
		timeOutCounter++
	}
}

waitForCursorToBePointerForABit()
{
	timeOutCounter:=0
	Loop
	{
		if ((A_Cursor ="Arrow") && (timeOutCounter < 200))
			Continue
		Else
			Break
	}
}

; My custom Toggle Checkbox function...
customToggle(classNN, winTitle)
{
	ControlGet, isOrIsntChecked, Checked,, %classNN%, %winTitle%
	if (isOrIsntChecked = 0){
		Control Check,, %classNN%
	} else {
		Control Uncheck,, %classNN%
	}
}

; My custom Check / Uncheck function...
easyCheck(buttonsNumbersToCheck, winTitle)
{
	Loop, 3
	{
		for k, v in buttonsNumbersToCheck
		{
			Control, Check,, Button%v%, %winTitle%
		}
		if ErrorLevel
			{
				if a_index = 3
					ultimatum(A_ThisFunc)
				sleep 333
				Continue
			}
			Else
				Break
		break
	}
}

easyUncheck(buttonsNumbersToUncheck, winTitle)
{
	Loop, 3
	{
		for k, v in buttonsNumbersToUncheck
		{
			Control, Uncheck,, Button%v%, %winTitle%
		}
		if ErrorLevel
			{
				if a_index = 3
					ultimatum(A_ThisFunc)
				sleep 333
				Continue
			}
			Else
				Break
		break
	}	
}


easyReplaceText(editNumber, replacementText, winTitle)
{
	loop,3
	{
		loop, % editNumber.MaxIndex()
		{
			gg := % editNumber[a_index]
			ControlSetText, Edit%gg%, % replacementText[a_index], %winTitle%
			; MsgBox, Edit%editNumber%
		}
		if ErrorLevel
			{
				if a_index = 3
					ultimatum(A_ThisFunc)
				sleep 333
				Continue
			}
			Else
				Break
		break
	}
}

easyChoose(comboBoxNumber, whichOption, winTitle)
{
	loop, % comboBoxNumber.MaxIndex()
	{
		gg := % comboBoxNumber[a_index]
		Control, Choose,% whichOption[a_index],ComboBox%gg%, %winTitle%
	}
}

easyChooseString(comboBoxNumber, string, winTitle)
{
	loop, % comboBoxNumber.MaxIndex()
	{
		gg:= % comboBoxNumber[a_index]
		Control, ChooseString, % string[a_index], ComboBox%gg%, %winTitle%
	}
}


positionMeasureNumber(buttonNumber,myComboBox1,myComboBox2,HDistanceFromStaff,VDistanceFromStaff)
{
	ControlClick, Button%buttonNumber%, Measure Number,,,, NA
	WinWaitActive, Position Measure Number
	Control, Choose, %myComboBox1%, ComboBox1, Position Measure Number
	Control, Choose, %myComboBox2%, ComboBox2, Position Measure Number
	easyReplaceText([1,2], [HDistanceFromStaff,VDistanceFromStaff], "Position Measure Number")
	ControlClick, Button1, Position Measure Number,,,, NA
	WinWaitActive, Measure Number
}

;figure out a more efficient way
nothingSelected()
{
	WinMenuSelectItem, Finale,,Tools,Resize
	sleep 100
	WinMenuSelectItem, Finale,,Tools,Selection Tool
	sleep 100
}


killExtraInPrepper()
{
	IfWinExist, Finale, There must be at least 2 systems
	{
		WinActivate, Finale, There must be at least 2 systems
		Send {Enter}
		sleep 100
		IfWinExist, Space Systems Evenly
			WinClose, Space Systems Evenly
	}
}

applyToAllParts()
{
	WinWaitActive, Edit
	Send, !c
	WinWaitActive, Select Parts/Score
	Send, !a
	ControlFocus, SysListView321,Select Parts/Score
	Sleep, 100
	Send, {PgUp}
	Sleep, 100
	Send, {Space}
	Sleep, 100
	Send, {Enter}
	WinWaitActive, Edit
	send, !c
	WinWaitActive, Select Parts/Score
	Send, !n{Enter}
	WinWaitActive, Edit
}


forceMyPrefs()
{
	tryIt := runJWLuaScript("force-my-prefs.lua", "Force Joseph's Part/Score Preferences")
	if (tryIt == 1)
	{
		MsgBox, Because you're not using JW Lua and my JW Lua scripts, this is going to take a lot longer...
		updatePartsTemplate()
	}	
}


updatePartsTemplate()
{
	switchToInches()
	; if ((scoreOrPart = "part") Or (scoreOrPart = "allParts"))
	; {
	goToPageFormatForParts()
	pageFormatFor:="Page Format for Parts"
	Control, ChooseString, Inches, ComboBox2, %pageFormatFor%
	easyCheck([2,11],pageFormatFor)
	easyUncheck([6,9],pageFormatFor)
	easyReplaceText([2,3,4,5,6,7,8,9,10,11,15,16,17,18,23],[partPageWidth,partPageHeight,pageScalingPercent,staffHeight,systemScalingPercent,0,0,0,0,0,topPageMargin+partPage2OnPageMarginExtension,leftPageMargin,rightPageMargin,bottomPageMargin,topPageMargin+partTopFirstPageMarginExtension],pageFormatFor)
	; }
	Send, {Enter}
}
	
prepper(scoreOrPart,firstSysIndention,additionalOffsetForLeftScorePageMargin,additionalBottom)
{
	switchToInches()

	if (scoreOrPart = "score")
	{
		goToPageFormatForScore()
		pageFormatFor:="Page Format for Score"
		Control, ChooseString, Inches, ComboBox2, %pageFormatFor%
		easyCheck([2,6,11],pageFormatFor)
		easyUncheck([9],pageFormatFor)
		easyReplaceText([2,3,15,16,17,18,23,12,13,14],[scorePageWidth,scorePageHeight,topPageMargin+scorePage2OnPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,bottomPageMargin,partTopFirstPageMarginExtension+topPageMargin,0,firstSysIndention,0],pageFormatFor)
	}
	;fix page size, just in case
	goToPageSize()
	Send !a

	if (scoreOrPart = "part") {
		easyReplaceText([2,3], [partPageWidth, partPageHeight], "Page Size")
		Send, {Enter}
	}
	if (scoreOrPart = "score") {
		easyReplaceText([2,3], [scorePageWidth, scorePageHeight], "Page Size")
		Send, {Enter}
	}


	WinWaitActive, Finale
	goToEditSystemMargins()
	if (scoreOrPart = "score")
	{
		easyCheck([5,6,7,8,9], "Edit System Margins")
		easyReplaceText([1,2,3,4,5,6,7], [0,firstSysIndention,0,0,0,1,1], "Edit System Margins")
		ControlClick, Button1, Edit System Margins,,,, NA
	}
	if ((scoreOrPart = "part") Or (scoreOrPart = "allParts"))
	{
		Send !a
		easyCheck([5,6,7,8,9], "Edit System Margins")
		easyReplaceText([1,2,3,4,5,6], [0,0,0,0,0,1], "Edit System Margins")
		if (scoreOrPart = "allParts")
			applyToAllParts()
		if (scoreOrPart = "part")
			ControlClick, Button1, Edit System Margins,,,, NA
	}
	waitForCursorToGoFromHourGlassToArrow()


	;set page margins
	goToEditPageMargins()
	Send !a
	easyCheck([5,6,7,8,9], "Edit Page Margins")

	; establish .5 inch page margins for the entire document
	if (scoreOrPart = "part")
	{
		easyReplaceText([1,2,3,4], [topPageMargin+partTopFirstPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")
		ControlClick, Button1, Edit Page Margins,,,, NA
	}
	if (scoreOrPart = "allParts")
	{
		easyReplaceText([1,2,3,4], [topPageMargin+partTopFirstPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")
		applyToAllParts()
	}
	if (scoreOrPart = "score")
	{
		easyReplaceText([1,2,3,4],[topPageMargin+scoreTopFirstPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")
		ControlClick, Button1, Edit Page Margins,,,, NA
	}

	waitForCursorToGoFromHourGlassToArrow()

	Loop
	{
		InputBox, numFromInputBox,Systems per Page,How many systems should go on page 1?
		if ErrorLevel
			Break
		Else
		{
			;WinActivate, Finale
			WinWaitActive, Finale
			goToSpaceSystemsEvenly()
			if (scoreOrPart = "allParts")
				Control, ChooseString,All Parts,ComboBox1,Space Systems Evenly
			Send !p!c
			page2TopSystem:=numFromInputBox+1
			page2SecondToTopSystem:=numFromInputBox+2
			easyReplaceText([5], [numFromInputBox], "Space Systems Evenly")
			ControlClick, Button1, Space Systems Evenly,,,, NA
			waitForCursorToGoFromHourGlassToArrow()
			if (scoreOrPart = "allParts")
			{
				goToSpaceSystemsEvenly()
				Control, ChooseString,Current Part or Score,ComboBox1,Space Systems Evenly
				Send, {Enter}
			}
			waitForCursorToGoFromHourGlassToArrow()
			killExtraInPrepper()
			WinWaitActive, Finale
			Continue
		}
	}
	

	; fix page margins for rest of document
	goToEditPageMargins()
	easyCheck([5,6,7,8,9], "Edit Page Margins")
	; sleep 100
	Send !g{tab 2}2
	; sleep 100
	if (scoreOrPart = "part")
		{
			easyReplaceText([1,2,3,4],[topPageMargin+partPage2OnPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")	
			ControlClick, Button1, Edit Page Margins,,,, NA
		}
		if (scoreOrPart = "allParts")
		{
			easyReplaceText([1,2,3,4],[topPageMargin+partPage2OnPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")		
			applyToAllParts()
		}
	if (scoreOrPart = "score")
	{
		easyReplaceText([1,2,3,4],[topPageMargin+scorePage2OnPageMarginExtension,leftPageMargin+additionalOffsetForLeftScorePageMargin,rightPageMargin,additionalBottom+bottomPageMargin], "Edit Page Margins")
		ControlClick, Button1, Edit Page Margins,,,, NA
	}
	waitForCursorToGoFromHourGlassToArrow()


	goToEditSystemMargins()
	easyCheck([5,6,7,8,9], "Edit System Margins")
	; sleep 100
	easyReplaceText([1,2,3,4,5,6,7], [0,0,0,0,0,page2TopSystem,page2TopSystem], "Edit System Margins")
	if ((scoreOrPart = "score") or (scoreOrPart = "part"))
		ControlClick, Button1, Edit System Margins,,,, NA
	if (scoreOrPart = "allParts")
		applyToAllParts()
	waitForCursorToGoFromHourGlassToArrow()
	easyUncheck([15],"Edit Page Margins")
	easyReplaceText([1,2,3,4,5,6], [0,0,0,0,0,page2SecondToTopSystem], "Edit System Margins")
	if ((scoreOrPart = "score") or (scoreOrPart = "part"))
		ControlClick, Button1, Edit System Margins,,,, NA
	if (scoreOrPart = "allParts")
		applyToAllParts()
	waitForCursorToGoFromHourGlassToArrow()

	Loop
	{
		InputBox, num2FromInputBox,Systems per Page,How many systems should go on page 2+?
		if ErrorLevel
			Break
		Else
		{
			WinActivate, Finale
			WinWaitActive, Finale
			goToSpaceSystemsEvenly()
			if (scoreOrPart = "allParts")
				Control, ChooseString,All Parts,ComboBox1,Space Systems Evenly
			Send !n
			; sleep 100
			easyReplaceText([5], [num2FromInputBox], "Space Systems Evenly")
			ControlClick, Button1, Space Systems Evenly,,,, NA
			waitForCursorToGoFromHourGlassToArrow()
			if (scoreOrPart = "allParts")
			{
				goToSpaceSystemsEvenly()
				Control, ChooseString,Current Part or Score,ComboBox1,Space Systems Evenly
				Send, {Enter}
			}
			killExtraInPrepper()
			Continue
		}
	}
}

; SciSetText("( ﾟ∀ﾟ)ｱﾊﾊ八八ﾉヽﾉヽﾉヽﾉ ＼ / ＼/ ＼", "Scintilla1", "Scratch Pad ahk_exe AutoHotkey.exe")

; GeekDude wrote this in like 10 minutes one night for fun... 
SciSetText(Text, Control, WinTitle)
{
	Static MEM_COMMIT := 0x1000, PAGE_READWRITE := 0x04, MEM_RELEASE := 0x8000
	Static SCI_SETTEXT := 2181
	WinGet, PID, PID, %WinTitle%
	
	hProcess := DllCall("OpenProcess", "UInt", 0x438 ; PROCESS-OPERATION|READ|WRITE|QUERY_INFORMATION
	, "Int", False ; inherit = false
	, "ptr", PID
	, "UPtr")
	
	Length := StrPutVar(Text, Buffer, "UTF-8")
	
	pBuffer := DllCall("VirtualAllocEx", "ptr", hProcess, "ptr", 0
	, "UInt", Length, "UInt", MEM_COMMIT, "UInt", PAGE_READWRITE, "UPtr")
	
	DllCall("WriteProcessMemory", "ptr", hProcess
	, "ptr", pBuffer, "ptr", &Buffer, "UInt", Length, "UPtr", 0)
	
	SendMessage, SCI_SETTEXT, 0, pBuffer, %Control%, %WinTitle%
	
	DllCall("VirtualFreeEx", "ptr", hProcess, "ptr", pBuffer, "ptr", 0, "UInt", MEM_RELEASE)
}

StrPutVar(string, ByRef var, encoding)
{
    ; Ensure capacity.
    VarSetCapacity( var, StrPut(string, encoding)
        ; StrPut returns char count, but VarSetCapacity needs bytes.
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
    ; Copy or convert the string.
    return StrPut(string, &var, encoding)
}
