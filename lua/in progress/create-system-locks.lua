local staffsystems = finale.FCStaffSystems()
staffsystems:LoadAll()
for ss in each(staffsystems) do
    -- local fs = finale.FCFreezeSystem()
    -- print(fs.ItemNo)
    -- ss:CreateFreezeSystem()
    test = finale.FCFreezeSystem():GetNextSysMeasure() 
    print(test)
end
