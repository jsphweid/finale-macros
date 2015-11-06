function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "make big time signatures in score"
    return "Time Signatures - Score - Make Big", "Time Signatures - Score - Make Big", "Score - Big Time Sigs"
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

setFont(finale.FONTPREF_TIMESIG, "EngraverTime", 40, 0, -290)

-- show only top (can use other script to display)
