WinActivate, Finale 
WinWaitActive, Finale
;=================

goToGlobalStaffAttributes()
{
	WinWaitActive, Finale
	WinMenuSelectItem,Finale,,Plug-ins,Scoring and Arranging,Global Staff Attributes...
	WinWaitActive, Global Staff Attributes,,.6
	if ErrorLevel
		goToGlobalStaffAttributes()
}

goToGlobalStaffAttributes()
customToggle("Button16", "Global Staff Attributes")
ControlFocus, Button1
Send {enter}