function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "use default measure numbers"
    return "Measure Numbers - Use Default", "Use Default Measure Numbers", "Use Default Measure Numbers"
end

-- delete existing regions
local mNumRegions = finale.FCMeasureNumberRegions()
mNumRegions:LoadAll()
for m in eachbackwards(mNumRegions) do
   m:DeepDeleteData()
end

-- establish font info for displayed measure numbers
local startFontInfo = finale.FCFontInfo()
startFontInfo.Italic = true
startFontInfo.Name = "Times New Roman"
startFontInfo.Absolute = true
startFontInfo.Size = 11

local multiMeasureFontInfo = finale.FCFontInfo()
multiMeasureFontInfo.Italic = true
multiMeasureFontInfo.Name = "Times New Roman"
multiMeasureFontInfo.Absolute = true
multiMeasureFontInfo.Size = 11

newRegion = finale.FCMeasureNumberRegion()
if newRegion then
   -- basics
   newRegion.StartMeasure = 1
   newRegion.EndMeasure = 999
   newRegion.UseScoreInfoForParts = true

   -- SCORE AND PARTS --
   newRegion:SetShowOnSystemStart(true)
   newRegion:SetHideFirstNumber(true)
   newRegion:SetShowOnTopStaff(true)
   newRegion:SetShowOnMultiMeasureRests(true)
   newRegion:SetShowMultiMeasureRange(true)
   
   -- start font info and position
   newRegion:SetStartFontInfo(startFontInfo)
   newRegion:SetStartAlignment(finale.MNALIGN_LEFT)
   newRegion:SetStartJustification(finale.MNJUSTIFY_LEFT)
   newRegion:SetStartHorizontalPosition(18) -- original was 6
   newRegion:SetStartVerticalPosition(56) -- original was 50

   -- multimeasure font info and position
   newRegion:SetMultiMeasureFontInfo(multiMeasureFontInfo)
   newRegion:SetMultiMeasureAlignment(finale.MNALIGN_CENTER)
   newRegion:SetMultiMeasureJustification(finale.MNJUSTIFY_CENTER)
   newRegion:SetMultiMeasureHorizontalPosition(0)
   newRegion:SetMultiMeasureVerticalPosition(-160) -- original was -175

   newRegion:SaveNew()
end
