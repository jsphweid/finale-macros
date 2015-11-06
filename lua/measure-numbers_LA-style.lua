function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "May 05, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "use LA-style measure numbers"
    return "Measure Numbers - LA Style", "Measure Numbers - LA Style", "Measure Numbers - LA Style"
end

-- delete existing regions
local mNumRegions = finale.FCMeasureNumberRegions()
mNumRegions:LoadAll()
local region = finale.FCMeasureNumberRegion()

for k = mNumRegions.Count,1,-1 do
   region:Load(k)
   region:DeleteData(k)
end

--------------------- 1 - displayed region ------------------------------
-- establish font info for displayed measure numbers
local multipleFontInfo = finale.FCFontInfo()
multipleFontInfo.Bold = true
multipleFontInfo.Name = "Times New Roman"
multipleFontInfo.Size = 22

local multiAndMultiMeasureFontInfo = finale.FCFontInfo()
multiAndMultiMeasureFontInfo.Italic = false
multiAndMultiMeasureFontInfo.Name = "Times New Roman"
multiAndMultiMeasureFontInfo.Size = 10
multiAndMultiMeasureFontInfo.EnigmaStyles = 2
multiAndMultiMeasureFontInfo.Hidden = false
multiAndMultiMeasureFontInfo.SizeFloat = 10
multiAndMultiMeasureFontInfo.StrikeOut = false
multiAndMultiMeasureFontInfo.Underline = false
multiAndMultiMeasureFontInfo.Absolute = false
multiAndMultiMeasureFontInfo.Bold = false

newRegion = finale.FCMeasureNumberRegion()
if newRegion then

   -- basics
   newRegion.StartMeasure = 1
   newRegion.EndMeasure = 999
   newRegion.UseScoreInfoForParts = false

   -- SCORE --
   newRegion:SetExcludeOtherStaves(true)
   newRegion:SetShowOnBottomStaff(true)
   newRegion:SetShowOnMultiMeasureRests(true)
   newRegion:SetShowMultiples(true)
   -- multiple font info and position
   newRegion:SetMultipleFontInfo(multipleFontInfo, false)
   newRegion:SetMultipleFontInfo(multiAndMultiMeasureFontInfo, true)
   newRegion:SetMultipleAlignment(finale.MNALIGN_CENTER, false) --- BROKEN>>>??
   newRegion:SetMultipleAlignment(finale.MNALIGN_CENTER, true) --- BROKEN>>>??
   newRegion:SetMultipleJustification(finale.MNJUSTIFY_CENTER, false)
   newRegion:SetMultipleHorizontalPosition(0)
   newRegion:SetMultipleVerticalPosition(-270)

   newRegion:SetMultipleValue(1, true)
   newRegion:SetMultipleValue(1, false)

   newRegion:SetStartFontInfo(multiAndMultiMeasureFontInfo, true)
   newRegion:SetStartFontInfo(multiAndMultiMeasureFontInfo, false)

   newRegion:SetStartVerticalPosition(44, true)
   newRegion:SetStartVerticalPosition(44, false)

   -- LINKED PARTS --
   newRegion:SetExcludeOtherStaves(true, true)
   newRegion:SetShowOnTopStaff(true, true)
   newRegion:SetShowMultiples(true, true)
   newRegion:SetShowMultiMeasureRange(true, true)
   -- multiple font info and position for parts
   newRegion:SetMultipleAlignment(finale.MNALIGN_CENTER, true) --- BROKEN>>>??
   newRegion:SetMultipleJustification(finale.MNJUSTIFY_CENTER, true)
   newRegion:SetMultipleHorizontalPosition(0, true)
   newRegion:SetMultipleVerticalPosition(-175, true)
   -- multimeasure font info and position for parts
   newRegion:SetMultiMeasureFontInfo(multiAndMultiMeasureFontInfo, true)
   newRegion:SetMultiMeasureFontInfo(multiAndMultiMeasureFontInfo, false)
   newRegion:SetMultiMeasureAlignment(finale.MNALIGN_CENTER, true) --- BROKEN>>>??
   newRegion:SetMultiMeasureAlignment(finale.MNALIGN_CENTER, false) --- BROKEN>>>??
   newRegion:SetMultiMeasureJustification(finale.MNJUSTIFY_CENTER, true)
   newRegion:SetMultiMeasureHorizontalPosition(0, true)
   newRegion:SetMultiMeasureVerticalPosition(-175, true)
   newRegion:SetMultiMeasureVerticalPosition(44, false)
   newRegion:SaveNew()
end

--------------------- 2 - hidden region ------------------------------

-- establish font info for hidden measure numbers
local hiddenFontInfo = finale.FCFontInfo()
hiddenFontInfo.Bold = true
hiddenFontInfo.Name = "Times New Roman"
hiddenFontInfo.Size = 22
hiddenFontInfo.Hidden = true

local hiddenFontInfoParts = finale.FCFontInfo()
hiddenFontInfoParts.Absolute = false
hiddenFontInfoParts.Bold = false
hiddenFontInfoParts.EnigmaStyles = 2
hiddenFontInfoParts.Hidden = false
hiddenFontInfoParts.Italic = true
hiddenFontInfoParts.Size = 10
hiddenFontInfoParts.SizeFloat = 10
hiddenFontInfoParts.StrikeOut = false
hiddenFontInfoParts.Underline = false

local hiddenFontInfoMMPartsScore = finale.FCFontInfo() -- same for score and parts
hiddenFontInfoMMPartsScore.Absolute = false
hiddenFontInfoMMPartsScore.Bold = false
hiddenFontInfoMMPartsScore.EnigmaStyles = 2
hiddenFontInfoMMPartsScore.Hidden = false
hiddenFontInfoMMPartsScore.Italic = true
hiddenFontInfoMMPartsScore.Size = 10
hiddenFontInfoMMPartsScore.SizeFloat = 10
hiddenFontInfoMMPartsScore.StrikeOut = false
hiddenFontInfoMMPartsScore.Underline = false

local hiddenStartFontInfoPartsScore = finale.FCFontInfo() -- same for score and parts
hiddenStartFontInfoPartsScore.Absolute = false
hiddenStartFontInfoPartsScore.Bold = false
hiddenStartFontInfoPartsScore.EnigmaStyles = 2
hiddenStartFontInfoPartsScore.Hidden = false
hiddenStartFontInfoPartsScore.Italic = true
hiddenStartFontInfoPartsScore.Size = 10
hiddenStartFontInfoPartsScore.SizeFloat = 10
hiddenStartFontInfoPartsScore.StrikeOut = false
hiddenStartFontInfoPartsScore.Underline = false

newHiddenRegion = finale.FCMeasureNumberRegion()
if newHiddenRegion then
   newHiddenRegion.StartMeasure = 1
   newHiddenRegion.EndMeasure = 999
   newHiddenRegion.UseScoreInfoForParts = false

   newHiddenRegion:SetShowOnMultiMeasureRests(true)
   newHiddenRegion:SetShowMultiples(true)

   -- multiple font info and position
   newHiddenRegion:SetMultipleFontInfo(hiddenFontInfoParts, true)
   newHiddenRegion:SetMultipleFontInfo(hiddenFontInfo, false)

   newHiddenRegion:SetStartFontInfo(hiddenStartFontInfoPartsScore, true)
   newHiddenRegion:SetStartFontInfo(hiddenStartFontInfoPartsScore, false)
   newHiddenRegion:SetMultiMeasureFontInfo(hiddenFontInfoMMPartsScore, true) -- parts
   newHiddenRegion:SetMultiMeasureFontInfo(hiddenFontInfoMMPartsScore, false) -- score
   newHiddenRegion:SetMultipleAlignment(finale.MNALIGN_CENTER, false) --- BROKEN>>>??
   newHiddenRegion:SetMultipleAlignment(finale.MNALIGN_CENTER, true) --- BROKEN>>>??
   newHiddenRegion:SetMultipleJustification(finale.MNJUSTIFY_CENTER, false)
   newHiddenRegion:SetMultipleJustification(finale.MNJUSTIFY_CENTER, true)

   newHiddenRegion:SetMultipleValue(1, true)
   newHiddenRegion:SetMultipleValue(1, false)

   newHiddenRegion:SetMultiMeasureJustification(2, true)

   newHiddenRegion:SetMultipleHorizontalPosition(0, false)
   newHiddenRegion:SetMultipleVerticalPosition(-270, false)
   newHiddenRegion:SetMultipleVerticalPosition(-175, true)
   newHiddenRegion:SetMultiMeasureVerticalPosition(44, false)
   newHiddenRegion:SetMultiMeasureVerticalPosition(-175, true)

   newHiddenRegion:SetStartVerticalPosition(44, true)
   newHiddenRegion:SetStartVerticalPosition(44, false)

   newHiddenRegion:SetMultiMeasureAlignment(1, true) --- BROKEN>>>??
   
   newHiddenRegion:SaveNew()
end