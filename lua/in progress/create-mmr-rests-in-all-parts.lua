local parts = finale.FCParts()
parts:LoadAll()
for p in each(parts) do  
	p:SwitchTo()
	local measures = finale.FCMeasures()
	measures:LoadAll()
	for m in each(measures) do
		local noteEntry = finale.FCNoteEntry() -- error
   end
   
	p:SwitchBack()    
end