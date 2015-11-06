-- Add Inserts to Part Score v0.01
-- measurements in EVPUs
-- add .ini file?

function deleteAllPageTexts()
   local page_texts = finale.FCPageTexts()
   page_texts:LoadAll()
   for i = page_texts.Count-1, 0, -1 do
        p = page_texts:GetItemAt(0) -- Requires a 0-based collection index
        p:DeleteData()

   end
end

offset = 0

inserts = {
  {"^font(Times New Roman)^size(26)^nfx(1)^title()", "center", 0, -230, 1, 1},
  {"^font(Times New Roman)^size(11)^nfx(2)^subtitle()", "center", 0, -346, 1, 1},
  {"^font(Times New Roman)^size(18)^nfx(1)^partname()", "left", 144, -86, 1, 1},
  {"^font(Times New Roman)^size(18)^nfx(1)^copyright()", "right", -144, -86, 1, 1},
  {"^font(Times New Roman)^size(12)^nfx(1)^composer()", "right", -144, -461, 1, 1},
  {"^font(Times New Roman)^size(14)^nfx(1)^partname()", "left", 144, -86, 2, 998},
  {"^font(Times New Roman)^size(12)^nfx(1)^title()", "right", -144, -86, 2, 998},
  {"^font(Times New Roman)^size(14)^nfx(1)^page(0)", "center", 0, -86, 2, 998},
  {"^font(Times New Roman)^size(18)^nfx(192)Total Pages  =  ^totpages()", "center", -288, -14, 1, 1}
}

deleteAllPageTexts() -- comment this out if you want to keep existing page texts

-- check if title page exists
local p = finale.FCPage()
if p:Load(1) then
   firstSys = p:GetFirstSystem()
   if firstSys == -1 then
      offset = 1
   end
end

for i, insertProfile in ipairs(inserts) do
   local pagetext = finale.FCPageText()
   if insertProfile[2] == "center" then
      pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_CENTER
      elseif insertProfile[2] == "left"
         then pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_LEFT
         elseif insertProfile[2] == "right"
            then pagetext.HorizontalAlignment = finale.TEXTHORIZALIGN_RIGHT
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

   -- -------- here is some old JW code from the example I derived the script from ----
   -- -------- I don't think it is necessary because we apply it to ALL parts...? ----
   
   -- -- Load all parts
   -- local allparts = finale.FCParts()
   -- allparts:LoadAll()

   -- Parse through all parts and RESAVE the existing page text object
   -- for part in each(allparts) do
   --    -- Page text will only be visible in the part/score where it was created
   --    -- pagetext.Visible = part:IsCurrent()    
   --    part:SwitchTo()
   --    pagetext:Save()
   --    part:SwitchBack()    
   -- end
end
