-- ONES ALREADY DONE, JUST NEED PASTING IN HERE
-- measure-numbers_freund.lua




-- FIX ALL THINGS CATEGORY DEFS (defaults only)
-- fix tempo alterations
local categorydefs = finale.FCCategoryDefs()
categorydefs:LoadAll()
name = finale.FCString()

tempoAlterationsFontInfo = finale.FCFontInfo()
tempoAlterationsFontInfo.Italic = true
tempoAlterationsFontInfo.Bold = true
tempoAlterationsFontInfo.Name = "Times New Roman"
tempoAlterationsFontInfo.Absolute = true
tempoAlterationsFontInfo.Size = 12
tempoAlterationsFontInfo.Underline = false
tempoAlterationsFontInfo.Hidden = false
tempoAlterationsFontInfo.StrikeOut = false

for eachDef in each(categorydefs) do
	eachDef:GetName(name)
	if (name.LuaString == "Tempo Alterations") then
		eachDef:SetTextFontInfo(tempoAlterationsFontInfo)
		categorydefs:SaveAll()
	end
end
