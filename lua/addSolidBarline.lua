function plugindef()
	finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "November 12, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "barline"
    return "Add Solid Barline", "Add Solid Barline", "Add Solid Barline to end of selected measure"
end

region = finale.FCMusicRegion()
region:SetCurrentSelection()
measures = finale.FCMeasures()
measures:LoadRegion(region)

for m in eachbackwards(measures) do
	m.Barline = finale.BARLINE_THICK
	m:Save()
    if true then break end -- only do it once, basically
end
