function plugindef()
	finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 05, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "create expression"
    return "Expression - Create Bold Above", "Expression - Create Bold Above", "Expression - Create Bold Above"
end

-- Show user dialog box
local dialog = finenv.UserValueInput()
dialog.Title = "Create Expression"
dialog:SetTypes("String")
dialog:SetDescriptions("Type the expression. Metakey will be 'a'")
local userInput = dialog:Execute()
if not userInput then return end
 
local expressionText = userInput[1]

function makeBoldAbove(expText)
  local ted = finale.FCTextExpressionDef()

  -- actual text
  stringObject = finale.FCString()
  stringObject.LuaString = "^fontTxt(Times New Roman,4096)^size(14)^nfx(1)" .. expText
  ted:SaveNewTextBlock(stringObject)

  -- description
  local descriptionstr = finale.FCString()
  descriptionstr.LuaString = expText -- get it from userinput also, why not
  ted:SetDescription(descriptionstr)

  -- put into which category?
  catdef = finale.FCCategoryDef()
  catdef:Load(4) -- 4 is expressions
  ted:AssignToCategory(catdef)

  -- we will not use standard positioning
  ted:SetUseCategoryPos(false)

  -- here is the positioning data
  ted:SetVerticalAlignmentPoint(finale.ALIGNVERT_ABOVE_STAFF_BASELINE_OR_ENTRY)
  ted:SetVerticalBaselineOffset(-26)
  ted:SetVerticalEntryOffset(36)
  ted:SetHorizontalJustification(finale.EXPRJUSTIFY_LEFT)
  ted:SetHorizontalAlignmentPoint(finale.ALIGNHORIZ_CLICKPOS)
  ted:SetHorizontalOffset(0)
  ted:SetBreakMMRest(false)

  ted:SaveNew()

  local ma = finale.FCMetatoolAssignment()
  ma:SetMode(finale.MTOOLMODE_EXPRESSION)
  ma:AssignTextExpressionDef(ted)
  ma:SaveAsKeystroke(65)


  return ted:GetItemNo()
end

local expressionID = makeBoldAbove(expressionText) -- create it and get its new ID