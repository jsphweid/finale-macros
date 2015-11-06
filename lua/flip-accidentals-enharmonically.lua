function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 08, 2015"
    finaleplugin.RequireSelection = true
    finaleplugin.CategoryTags = "flip, accidental, enharmonic"
    return "Flip Accidentals Enharmonically", "Flip Accidentals Enharmonically", "Toggles sharps to flats or flats to sharps in selected region."
end

-- table for checking whether note has accidental
isAccidentalTbl = {'A#', 'B#', 'C#', 'D#', 'E#', 'F#', 'G#',
                    'Cb', 'Fb', 'Bb', 'Db', 'Eb', 'Gb', 'Ab',
                    'F##', 'G##', 'A##', 'B##', 'C##', 'D##', 'E##',
                    'Fbb', 'Gbb', 'Abb', 'Bbb', 'Cbb', 'Dbb', 'Ebb'}

-- conversion tables
tblOne = {'F##', 'G##', 'A##', 'C##', 'D##', 'E##',
            'Fbb', 'Gbb', 'Abb', 'Bbb', 'Dbb', 'Ebb',
            'A#', 'C#', 'D#', 'E#', 'F#',
            'G#', 'Fb', 'Bb', 'Db', 'Eb', 'Gb',
            'Ab', 'E',
            'B0', 'B1', 'B2', 'B3', -- to handle the break in octave tranpositions
            'B4', 'B5', 'B6', 'B7', 'B8', 'B9',
            'B10', 'B11', 'B12', 'B13', 'Cb1', 'Cb2',
            'Cb3', 'Cb4', 'Cb5', 'Cb6', 'Cb7', 'Cb8',
            'Cb9', 'Cb10', 'Cb11', 'Cb12', 'Cb13', 'Cb14',
            'B#0', 'B#1', 'B#2', 'B#3',
            'B#4', 'B#5', 'B#6', 'B#7',
            'B#8', 'B#9', 'B#10', 'B#11',
            'B#12', 'B#13',
            'B##0', 'B##1', 'B##2', 'B##3',
            'B##4', 'B##5', 'B##6', 'B##7',
            'B##8', 'B##9', 'B##10', 'B##11',
            'B##12', 'B##13',
            'Cbb1', 'Cbb2', 'Cbb3', 'Cbb4',
            'Cbb5', 'Cbb6', 'Cbb7', 'Cbb8',
            'Cbb9', 'Cbb10', 'Cbb11', 'Cbb12',
            'Cbb13', 'Cbb14'}
tblTwo = {'G', 'A', 'B', 'D', 'E', 'Gb',
            'D#', 'F', 'G', 'A', 'C', 'D',
            'Bb', 'Db', 'Eb', 'F', 'Gb',
            'Ab', 'E', 'A#', 'C#', 'D#', 'F#',
            'G#', 'Fb',
            'Cb1', 'Cb2', 'Cb3', 'Cb4', -- to handle the break in octave tranpositions
            'Cb5', 'Cb6', 'Cb7', 'Cb8', 'Cb9', 'Cb10',
            'Cb11', 'Cb12', 'Cb13', 'Cb14', 'B0', 'B1',
            'B2', 'B3', 'B4', 'B5', 'B6', 'B7',
            'B8', 'B9', 'B10', 'B11', 'B12', 'B13',
            'C1', 'C2', 'C3', 'C4',
            'C5', 'C6', 'C7', 'C8',
            'C9', 'C10', 'C11', 'C12',
            'C13', 'C14',
            'Db1', 'Db2', 'Db3', 'Db4',
            'Db5', 'Db6', 'Db7', 'Db8',
            'Db9', 'Db10', 'Db11', 'Db12',
            'Db13', 'Db14',
            'A#0', 'A#1', 'A#2', 'A#3',
            'A#4', 'A#5', 'A#6', 'A#7',
            'A#8', 'A#9', 'A#10', 'A#11',
            'A#12', 'A#13'}

-- establish the containers
local pitchString = finale.FCString()
local soundingPitchString = finale.FCString()

-- check whether 'display in concert pitch' is checked or not so that 
-- one can always flip what they see and not be limited to what it's written pitch is
local partscopeprefs = finale.FCPartScopePrefs()
partscopeprefs:Load(1)

if partscopeprefs.DisplayInConcertPitch then
    for entry in eachentrysaved(finenv.Region()) do
        if entry:IsNote() then
            for note in each(entry) do
                note:GetString(soundingPitchString, nil, false, false)
                for k, v in ipairs(isAccidentalTbl) do
                    if soundingPitchString:ContainsLuaString(v, nil) then
                        for k1, v1 in ipairs(tblOne) do
                            if soundingPitchString:ContainsLuaString(v1, nil) then
                                soundingPitchString:Replace(tblOne[k1], tblTwo[k1])
                                note:SetString(soundingPitchString, nil, false, false)
                                entry.CheckAccidentals = true
                                break
                            end
                        end
                        break
                    end
                end
            end
        end
    end
else
    for entry in eachentrysaved(finenv.Region()) do
        if entry:IsNote() then
            for note in each(entry) do
                note:GetString(pitchString, nil, false, true)
                note:GetString(soundingPitchString, nil, false, false)
                for k, v in ipairs(isAccidentalTbl) do
                    if pitchString:ContainsLuaString(v, nil) then
                        for k1, v1 in ipairs(tblOne) do
                            if soundingPitchString:ContainsLuaString(v1, nil) then
                                soundingPitchString:Replace(tblOne[k1], tblTwo[k1])
                                note:SetString(soundingPitchString, nil, false, false)
                                entry.CheckAccidentals = true
                                break
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end