function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "May 02, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "selected noteheads to x-shaped"
    return "X-Shaped Noteheads - Change", "X-Shaped Noteheads - Change", "Make X-Shaped Noteheads"
end

for entry in eachentrysaved(finenv.Region()) do
	if entry:IsNote() then -- not sure if this is necessary
	   for note in each(entry) do
	      local notehead = finale.FCNoteheadMod()
	      notehead.CustomChar = 192 -- x-shape
	      notehead:SaveAt(note)
	   end
	end
end