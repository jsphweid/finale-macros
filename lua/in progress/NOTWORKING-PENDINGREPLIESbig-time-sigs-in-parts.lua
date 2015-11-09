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

setFont(finale.FONTPREF_TIMESIG_Parts, "EngraverTextT", 28, -17, -58)

-- show only top (can use other script to display)