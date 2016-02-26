function plugindef()
	finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 03, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "transpose"
    return "Quick Transpose", "Quick Transpose", "Transpose selected area quickly based on user input."
end

function transpose(interval, preserve)
	for entry in eachentrysaved(finenv.Region()) do
		if entry:IsNote() then
			for note in eachbackwards(entry) do
				local thisNote = note:CalcMIDIKey()
				local octaveUpCalc = thisNote + interval
				newNote = entry:AddNewNote()
				newNote:SetMIDIKey(octaveUpCalc)
				if (preserve == false) then
			   		entry:DeleteNote(note)
			   	end
	      end
	   end
	end
	refreshAccidentals()
end

function refreshAccidentals()
	for e in eachentrysaved(finenv.Region()) do
		if e:IsNote() then
	    	e.CheckAccidentals = true   -- Assure proper accidental refresh
   		end
	end
end

-- Show user dialog box
local dialog = finenv.UserValueInput()
dialog.Title = "Transpose"
dialog:SetTypes("String")
dialog:SetDescriptions("umaj3=up maj 3rd & pdmin7=preserve down min 7th")
-- dialog:SetInitValues(1)
local returnvalues = dialog:Execute()
if not returnvalues then return end
 
local transposeWhat = returnvalues[1]

-- 1 or min2
if transposeWhat == "umin2" then transpose(1, false) end
if transposeWhat == "u1" then transpose(1, false) end
if transposeWhat == "pumin2" then transpose(1, true) end
if transposeWhat == "pu1" then transpose(1, true) end
if transposeWhat == "dmin2" then transpose(-1, false) end
if transposeWhat == "d1" then transpose(-1, false) end
if transposeWhat == "pdmin2" then transpose(-1, true) end
if transposeWhat == "pd1" then transpose(-1, true) end

-- 2 or maj2
if transposeWhat == "umaj2" then transpose(2, false) end
if transposeWhat == "u2" then transpose(2, false) end
if transposeWhat == "pumaj2" then transpose(2, true) end
if transposeWhat == "pu2" then transpose(2, true) end
if transposeWhat == "dmaj2" then transpose(-2, false) end
if transposeWhat == "d2" then transpose(-2, false) end
if transposeWhat == "pdmaj2" then transpose(-2, true) end
if transposeWhat == "pd2" then transpose(-2, true) end

-- 3 or min3
if transposeWhat == "umin3" then transpose(3, false) end
if transposeWhat == "u3" then transpose(3, false) end
if transposeWhat == "pumin3" then transpose(3, true) end
if transposeWhat == "pu3" then transpose(3, true) end
if transposeWhat == "dmin3" then transpose(-3, false) end
if transposeWhat == "d3" then transpose(-3, false) end
if transposeWhat == "pdmin3" then transpose(-3, true) end
if transposeWhat == "pd3" then transpose(-3, true) end

-- 4 or maj3
if transposeWhat == "umaj3" then transpose(4, false) end
if transposeWhat == "u4" then transpose(4, false) end
if transposeWhat == "pumaj3" then transpose(4, true) end
if transposeWhat == "pu4" then transpose(4, true) end
if transposeWhat == "dmaj3" then transpose(-4, false) end
if transposeWhat == "d4" then transpose(-4, false) end
if transposeWhat == "pdmaj3" then transpose(-4, true) end
if transposeWhat == "pd4" then transpose(-4, true) end

-- 5 or p4
if transposeWhat == "up4" then transpose(5, false) end
if transposeWhat == "u5" then transpose(5, false) end
if transposeWhat == "pup4" then transpose(5, true) end
if transposeWhat == "pu5" then transpose(5, true) end
if transposeWhat == "dp4" then transpose(-5, false) end
if transposeWhat == "d5" then transpose(-5, false) end
if transposeWhat == "pdp4" then transpose(-5, true) end
if transposeWhat == "pd5" then transpose(-5, true) end

-- 6 or tt
if transposeWhat == "utt" then transpose(6, false) end
if transposeWhat == "u6" then transpose(6, false) end
if transposeWhat == "putt" then transpose(6, true) end
if transposeWhat == "pu6" then transpose(6, true) end
if transposeWhat == "dtt" then transpose(-6, false) end
if transposeWhat == "d6" then transpose(-6, false) end
if transposeWhat == "pdtt" then transpose(-6, true) end
if transposeWhat == "pd6" then transpose(-6, true) end

-- 7 or p5
if transposeWhat == "up5" then transpose(7, false) end
if transposeWhat == "u7" then transpose(7, false) end
if transposeWhat == "pup5" then transpose(7, true) end
if transposeWhat == "pu7" then transpose(7, true) end
if transposeWhat == "dp5" then transpose(-7, false) end
if transposeWhat == "d7" then transpose(-7, false) end
if transposeWhat == "pdp5" then transpose(-7, true) end
if transposeWhat == "pd7" then transpose(-7, true) end

-- 8 or min6
if transposeWhat == "umin6" then transpose(8, false) end
if transposeWhat == "u8" then transpose(8, false) end
if transposeWhat == "pumin6" then transpose(8, true) end
if transposeWhat == "pu8" then transpose(8, true) end
if transposeWhat == "dmin6" then transpose(-8, false) end
if transposeWhat == "d8" then transpose(-8, false) end
if transposeWhat == "pdmin6" then transpose(-8, true) end
if transposeWhat == "pd8" then transpose(-8, true) end

-- 9 or maj6
if transposeWhat == "umaj6" then transpose(9, false) end
if transposeWhat == "u9" then transpose(9, false) end
if transposeWhat == "pumaj6" then transpose(9, true) end
if transposeWhat == "pu9" then transpose(9, true) end
if transposeWhat == "dmaj6" then transpose(-9, false) end
if transposeWhat == "d9" then transpose(-9, false) end
if transposeWhat == "pdmaj6" then transpose(-9, true) end
if transposeWhat == "pd9" then transpose(-9, true) end

-- 10 or min7
if transposeWhat == "umin7" then transpose(10, false) end
if transposeWhat == "u10" then transpose(10, false) end
if transposeWhat == "pumin7" then transpose(10, true) end
if transposeWhat == "pu10" then transpose(10, true) end
if transposeWhat == "dmin7" then transpose(-10, false) end
if transposeWhat == "d10" then transpose(-10, false) end
if transposeWhat == "pdmin7" then transpose(-10, true) end
if transposeWhat == "pd10" then transpose(-10, true) end

-- 11 or maj7
if transposeWhat == "umaj7" then transpose(11, false) end
if transposeWhat == "u11" then transpose(11, false) end
if transposeWhat == "pumaj7" then transpose(11, true) end
if transposeWhat == "pu11" then transpose(11, true) end
if transposeWhat == "dmaj7" then transpose(-11, false) end
if transposeWhat == "d11" then transpose(-11, false) end
if transposeWhat == "pdmaj7" then transpose(-11, true) end
if transposeWhat == "pd11" then transpose(-11, true) end

-- 12 or p8
if transposeWhat == "up8" then transpose(12, false) end
if transposeWhat == "u12" then transpose(12, false) end
if transposeWhat == "pup8" then transpose(12, true) end
if transposeWhat == "pu12" then transpose(12, true) end
if transposeWhat == "dp8" then transpose(-12, false) end
if transposeWhat == "d12" then transpose(-12, false) end
if transposeWhat == "pdp8" then transpose(-12, true) end
if transposeWhat == "pd12" then transpose(-12, true) end
