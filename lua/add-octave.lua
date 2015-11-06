function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "add octave"
    return "Add Octave", "Add Octave", "Add Octave to selected area"
end

for entry in eachentrysaved(finenv.Region()) do
   if entry:IsNote() then
      for note in eachbackwards(entry) do
         local thisNote = note:CalcMIDIKey()
         local octaveUpCalc = thisNote + 12
         newNote = entry:AddNewNote()
         newNote:SetMIDIKey(octaveUpCalc)
      end
   end
end