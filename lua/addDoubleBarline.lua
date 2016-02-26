function plugindef()
	finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "November 12, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "barline"
    return "Add Double Barline", "Add Double Barline", "Add Double Barline to end of selected measure"
end

region = finale.FCMusicRegion()
region:SetCurrentSelection()
measures = finale.FCMeasures()
measures:LoadRegion(region)

for m in eachbackwards(measures) do
	m.Barline = finale.BARLINE_DOUBLE
	m:Save()
    if true then break end -- only do it once, basically
end
