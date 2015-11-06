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
	-- distanceprefs.TimeSigTopVertical = topSymbol
	-- distanceprefs.TimeSigBottomVertical = bottomSymbol 
	distanceprefs:Save()

end

setFont(finale.FONTPREF_TIMESIG_PARTS, "Maestro", 24, 0, 0)

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
