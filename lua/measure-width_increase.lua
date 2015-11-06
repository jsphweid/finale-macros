function plugindef()
    finaleplugin.Author = "Jari Williamsson then altered by Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "May 03, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "increase measure width"
    return "Measure Width - Increase", "Measure Width - Increase", "Increase Measure Width"
end


-- this script was completely written by Jari in his preview post of JW Lua
-- on the MakeMusic Finale Forums - Posted 7/30/2013 4:14 PM (GMT -5)   
region = finale.FCMusicRegion()
region:SetCurrentSelection()
measures = finale.FCMeasures()
measures:LoadRegion(region)
for measure in each(measures) do
	measure.Width = measure.Width * 120 / 100 
end
measures:SaveAll()	