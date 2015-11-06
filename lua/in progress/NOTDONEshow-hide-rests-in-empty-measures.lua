local measures = finale.FCMeasures()
measures:LoadAll()
for m in each(measures) do    
   print(m.ItemNo)
end