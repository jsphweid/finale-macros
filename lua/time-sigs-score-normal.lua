function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "normal time signatures"
    return "Time Signatures - Score - Normal", "Time Signatures - Score - Normal", "Changes to Normal Time Signatures"
end

function setFont(fontID, fontName, fontSize, topSymbol, bottomSymbol)
	-- load font preferences for fontID
	local fontPrefs = finale.FCFontPrefs()
	fontPrefs:Load(fontID)
	local fontInfo = fontPrefs:CreateFontInfo()

	-- set name / size
	fontInfo:SetName(fontName)
	fontInfo:SetSize(fontSize)

	-- save it back
	fontPrefs:SetFontInfo(fontInfo)
   fontPrefs:Save()

   local distanceprefs = finale.FCDistancePrefs()
	distanceprefs:Load(1)
	distanceprefs.TimeSigTopVertical = topSymbol
	distanceprefs.TimeSigBottomVertical = bottomSymbol 
	distanceprefs:Save()

end

setFont(finale.FONTPREF_TIMESIG, "Maestro", 24, 0, 0)

-- show on every except tabs
local staves = finale.FCStaves()
staves:LoadAll()
for staff in each(staves) do
   if not staff:IsTablature() then
   	staff.ShowTimeSignatures = true
   else
   	staff.ShowTimeSignatures = false
   end
   staff:Save()
end
