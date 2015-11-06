-- Load existing notes in the cell
local region = finenv.Region()
notecell = finale.FCNoteEntryCell(region.StartMeasure, region.StartStaff)
notecell:Load()
-- Append to layer 1, add 1 entry
entry = notecell:AppendEntriesInLayer(1, 4)
if entry then
    entry.Duration = finale.QUARTER_NOTE
    entry.Legality = true   -- Must be set for a created note
    entry:MakeNote()
    local note = entry:GetItemAt(0)
    -- Assign a specific pitch to the note
    local pitch = finale.FCString()
    pitch.LuaString = "A4"
    -- Set pitch, using the note entry measure's key signature.
    -- Also use sounding pitch.
    note:SetString(pitch, nil, false)
    notecell:Save()
end