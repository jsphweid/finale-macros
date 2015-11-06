
function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "staff names uppercase"
    return "Staff Names - Make all uppercase", "Staff Names - Make all uppercase", "Make Staff Names Uppercase"
end

function ChangeStaffInstruments(wholeString, trimmedString)
	local upperTrimmedString = string.upper(trimmedString)
	if wholeString:ContainsLuaString(trimmedString, nil) then
		if string.len(trimmedString) > 0 then
			wholeString:Replace(trimmedString, upperTrimmedString)
		end
	end
	-- if wholeString:ContainsLuaString("B^FLAT()", nil) then
	-- 	wholeString:Replace("B^FLAT()", "B^flat()")
	-- end
	if wholeString:ContainsLuaString("^FLAT()", nil) then
		wholeString:Replace("B^FLAT()", "B^flat()")
		wholeString:Replace("E^FLAT()", "E^flat()")
		wholeString:Replace("A^FLAT()", "A^flat()")
		wholeString:Replace("G^FLAT()", "G^flat()")
		wholeString:Replace("D^FLAT()", "D^flat()")
	end
end
 
local staves = finale.FCStaves()
staves:LoadAll()
for staff in each(staves) do    
	local oldstring = staff:CreateFullNameString()
	local wholeString = staff:CreateFullNameString()
	local trimmedStringText = staff:CreateTrimmedFullNameString().LuaString
	ChangeStaffInstruments(wholeString, trimmedStringText)
	if oldstring.LuaString ~= wholeString.LuaString then
	  staff:SaveFullNameString(wholeString)
	end
end
