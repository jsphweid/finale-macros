allparts = finale.FCParts()
allparts:LoadAll()
for onepart in each (allparts) do
	onepart:SwitchTo()
	local staffsystems = finale.FCStaffSystems()
	staffsystems:LoadAll()
	local multimeasurerests = finale.FCMultiMeasureRests()
	multimeasurerests:LoadAll()
	local i = 1
	for ss in each(staffsystems) do
	    mmrLengths = 0
		for mmr in each(multimeasurerests) do -- take into account MMR
		    if ss:ContainsMeasure(mmr.StartMeasure) then
		    	mmrLengths = mmrLengths + (mmr.EndMeasure - mmr.StartMeasure) -- actual length - 1
		    end
		end
		-- finale.FCStaffSystems.UpdateFullLayout() -- takes a long time
	    ss:SetFirstMeasure_(i)
		i = i + 4 + mmrLengths + 1
		ss:SetNextSysMeasure_(i)
		ss:CreateFreezeSystem(true)
		ss:Save()
		-- local fs = finale.FCFreezeSystem()
		-- fs.NextSysMeasure = i
		-- fs:Save()
	end
	onepart:SwitchBack()
end