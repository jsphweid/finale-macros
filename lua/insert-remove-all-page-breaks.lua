function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "insert / remove page breaks"
    return "Insert / Remove All Page Breaks", "Insert / Remove All Page Breaks", "Insert / Remove All Page Breaks"
end

local firstMeasureTable = {}
local i = 1

-- populate table with the measure numbers at the top of each page
local pages = finale.FCPages()
pages:LoadAll()
for p in each(pages) do
    p:UpdateLayout()
    local firstM = p:CalcFirstMeasure()
    firstMeasureTable[i] = firstM
    i = i + 1
end

-- most of this logic is necessary as to create a uniformity
-- so that a page break status on the first page is the same
-- as the page break status on every other page
hasHappened = false
firstPB = false

-- create/destroy page breaks at those measures
local measures = finale.FCMeasures()
measures:LoadAll()
for m in each(measures) do
	for k, v in ipairs(firstMeasureTable) do
		if (m.ItemNo == v) then
			if (hasHappened == false) then
				hasHappened = true -- so it only happens once
				if (m.PageBreak == true) then
					firstPB = false
					m.PageBreak = false
				else
					firstPB = true
					m.PageBreak = true
				end
			end
			if (hasHappened == true) then
				if (firstPB == true) then
					m.PageBreak = true
				end
				if (firstPB == false) then
					m.PageBreak = false
				end
			end
		end
	end
end
measures:SaveAll()
