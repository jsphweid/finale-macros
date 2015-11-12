function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "add score inserts"
    return "Score - Add Inserts", "Score - Add Inserts", "Add Score Inserts"
end

-- inserts_titlePage = {
--   {"^font(Times New Roman)^size(32)^nfx(65)^title()", "center", 0, -518, 1, 1},
--   {"^font(Times New Roman)^size(14)^nfx(67)^subtitle()", "center", 0, -662, 1, 1},
--   {"^font(Times New Roman)^size(18)^nfx(65)^partname()", "left", 144, -86, 1, 1},
--   {"^font(Times New Roman)^size(18)^nfx(65)^copyright()", "right", -144, -86, 1, 1},
--   {"^font(Times New Roman)^size(12)^nfx(65)^composer()", "center", 0, -950, 1, 1},
-- }

offset = 0

inserts_everything = {
  {"^font(Times New Roman)^size(26)^nfx(65)^title()", "center", 0, -98, 1, 1},
  {"^font(Times New Roman)^size(14)^nfx(67)^subtitle()", "center", 0, -230, 1, 1},
  {"^font(Times New Roman)^size(12)^nfx(66)Estimated Time  =  ^perftime(4)", "center", 0, -360, 1, 1},
  {"^font(Times New Roman)^size(12)^nfx(66)Printed on ^date(2) at ^time(0)", "center", 0, -420, 1, 1},
  {"^font(Times New Roman)^size(18)^nfx(65)^partname()", "left", 144, -86, 1, 1},
  {"^font(Times New Roman)^size(18)^nfx(65)^copyright()", "right", -144, -86, 1, 1},
  {"^font(Times New Roman)^size(12)^nfx(65)^composer()", "right", -144, -259, 1, 1},
  {"^font(Times New Roman)^size(14)^nfx(65)^partname()", "left", 144, -144, 2, 998},
  {"^font(Times New Roman)^size(14)^nfx(65)^title()", "right", -144, -144, 2, 998},
  {"^font(Times New Roman)^size(14)^nfx(65)- ^page(0) -", "center", 0, -144, 2, 998},
  {"^font(Times New Roman)^size(18)^nfx(192)Total Pages  =  ^totpages()", "center", -288, -14, 1, 1}
}

-- function insertBlankPageIfNone()
-- 	local pages = finale.FCPages()
-- 	pages:LoadAll()
-- 	local page = finale.FCPage()
-- 	if page:Load(1) then
-- 		firstSys = page:GetFirstSystem()
-- 		if firstSys == 1 then -- first page is blank... but no set start system method or property
-- 			finale.FCPages.InsertBlank(1) 
-- 		end
-- 	end
-- end

function deletePageTexts()
	local page_texts = finale.FCPageTexts()
	page_texts:LoadAll()
	for i = page_texts.Count-1, 0, -1 do
		p = page_texts:GetItemAt(0) -- Requires a 0-based collection index
		p:DeleteData()
	end
end

function checkIfTitlePageExists()
	local p = finale.FCPage()
	if p:Load(1) then
		firstSys = p:GetFirstSystem()
		if firstSys == -1 then
			offset = 1
		end
	end
end

function addInserts(inserts)
	for i, insertProfile in ipairs(inserts) do
		local pagetext = finale.FCPageText()
		if insertProfile[2] == "center" then
			pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_CENTER
		elseif insertProfile[2] == "left" then
			pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_LEFT
		elseif insertProfile[2] == "right" then
			pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_RIGHT
		end
		pagetext.VerticalAlignment = finale.TEXTVERTALIGN_TOP
		pagetext.PageEdgeRef = true
		pagetext.HorizontalPos = insertProfile[3]
		pagetext.VerticalPos = insertProfile[4]
		pagetext.Visible = true
		pagetext.FirstPage = insertProfile[5] + offset
		pagetext.LastPage = insertProfile[6] + offset

		-- Create a FCString with the raw Enigma string
		local insertString = finale.FCString()
		insertString.LuaString = insertProfile[1]
		-- Save the raw text and text block first
		pagetext:SaveNewTextBlock(insertString)
		-- Save the page text to the page 1 storage
		pagetext:SaveNew(0)
	end
end

-- insertBlankPageIfNone() -- not for score
deletePageTexts() 
checkIfTitlePageExists() -- change offset, just in case...
addInserts(inserts_everything)