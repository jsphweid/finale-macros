function plugindef()
	finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 05, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "create expression"
    return "Create Expression - Bold Above", "Create Expression - Bold Above", "Create Expression - Bold Above"
end

-- Show user dialog box
local dialog = finenv.UserValueInput()
dialog.Title = "Create Expression"
dialog:SetTypes("String")
dialog:SetDescriptions("Type the expression. Metakey will be ")
local userInput = dialog:Execute()
if not userInput then return end
 
local expressionText = userInput[1]

-- Load through a collection: all items in measure 1
local expressions = finale.FCExpressions()
expressions:LoadAllForItem(1)
for e in each(expressions) do
    _return_val_ = e:CreateTextExpressionDef(_argument_list_)
end








function FindTextExpressionCategory(textvalue)

--look for the category with the name textvalue

--and, if found, return their IDs 

        -- Load all the category defs

        local catdefs = finale.FCCategoryDefs()

        catdefs:LoadAll()

        -- Search all category defs 

        for catdef in each(catdefs) do

            local catstring = catdef:CreateName()

            catstring:TrimEnigmaTags()

            if catstring:ContainsLuaString(textvalue) then 

               return catdef:GetItemNo(),catdef

            end

        end

        return -1,nil

end





function FindTextExpression(textvalue)

--look for the text expression with the name textvalue

--and, if found, return the ID

        -- Load all the text expression defs

        local exprdefs = finale.FCTextExpressionDefs()

        exprdefs:LoadAll()

        -- Search all text expression defs

        for exprdef in each(exprdefs) do

            local exprstring = exprdef:CreateTextString()

            exprstring:TrimEnigmaTags()

            if exprstring.LuaString == textvalue then

               return exprdef:GetItemNo()

            end

        end

        return -1

end



function GetExpressionCategory(categorytext,categoryalttext,categoryalttext2)

--Looks for the category with the given names

--If no category is found, use category 5 as default.

--Another idea would be to create a new category, 

--but this is not allowed in the Finale PDK

    local catid,catdef=FindTextExpressionCategory(categorytext)

    if (catid==-1) and (categoryalttext~=nil) then -- if category not found, use alternative category

       catid,catdef=FindTextExpressionCategory(categoryalttext)

    end

    if (catid==-1) and (categoryalttext2~=nil) then -- if alt category not found, use alternative category 2

       catid,catdef=FindTextExpressionCategory(categoryalttext2)

    end

    if catid == -1 then --if none of the categories exist, use category 5

       catid=5

       catdef = finale.FCCategoryDef()

       catdef:Load(catid)

    end

    return catid,catdef

end





function CreateNewTextExpression(textvalue,descriptionvalue,categorytext,categoryalttext,categoryalttext2)

--Creates the new text expression, saves it in the given category and returns the ID

    local catid,catdef = GetExpressionCategory(categorytext,categoryalttext,categoryalttext2)



    local exprdef = finale.FCTextExpressionDef()

    local textstr = finale.FCString()

    textstr.LuaString = textvalue

    exprdef:SaveNewTextBlock(textstr)

    if descriptionvalue==nil then

       descriptionvalue=textvalue

    end

    local descriptionstr = finale.FCString()

    descriptionstr.LuaString=descriptionvalue

    exprdef:SetDescription(descriptionstr)

    exprdef:AssignToCategory(catdef)

    exprdef:SetUseCategoryPos(false) --Set to true, if you wish to use the standard category positioning instead

    

--As we don't use category positioning here, we need to set the individual expression positioning

    exprdef:SetVerticalAlignmentPoint(finale.ALIGNVERT_ABOVE_STAFF_BASELINE)

    exprdef:SetVerticalBaselineOffset(0)

    exprdef:SetVerticalEntryOffset(0)

    exprdef:SetHorizontalJustification(finale.EXPRJUSTIFY_LEFT)

    exprdef:SetHorizontalAlignmentPoint(finale.ALIGNHORIZ_LEFTOFALLNOTEHEAD)

    exprdef:SetHorizontalOffset(0)

    exprdef:SetBreakMMRest(false)



    exprdef:SaveNew()

    return exprdef:GetItemNo()

end





function MakeTextExpression(textvalue,categorytext,descriptionvalue,categoryalttext,categoryalttext2)

--Checks if text expression already exists and creates a new one if necessary,

--then returns the ID

    categoryalttext=categoryalttext or nil

    categoryalttext=categoryalttext2 or nil

    descriptionvalue=descriptionvalue or nil

    local textid=FindTextExpression(textvalue)

    if textid>=0 then

        return textid

    else -- create text expression

       return CreateNewTextExpression(textvalue,descriptionvalue,categorytext,categoryalttext,categoryalttext2)

    end

end



function AttachExpression(staff,measure,measurepos,expressionID,horizontalPos,verticalPos)

--Attaches the expression to the given position



   horizontalPos=horizontalPos or 0

   verticalPos=verticalPos or 0



   local expression=finale.FCExpression()

   expression:SetStaff(staff)

   expression:SetVisible(true)

   expression:SetMeasurePos(measurepos)

   expression:SetHorizontalPos(horizontalPos)

   expression:SetVerticalPos(verticalPos)

   expression:SetScaleWithEntry(false)

   expression:SetLayerAssignment(0)

   expression:SetPartAssignment(true)

   expression:SetScoreAssignment(true)

   expression:SetPlaybackLayerAssignment(1)

   expression:SetID(expressionID)

   local cell = finale.FCCell(measure,staff)

   expression:SaveNewToCell(cell)

end



--Set region

local region=finale.FCMusicRegion()

region:SetCurrentSelection()



local TextExpressionID={}  --array to hold all text expression IDs used in this plugin

local TextExpressionText="TestExpr"  --Text of the new text expression

local TextExpressionDescription="This is the description"  --Description of the new text expression



if region.StartMeasure>0 then

  --Get TextExpressionID and attach expression to the first measure in the first selected staff on measure position 0

  TextExpressionID[TextExpressionText]=MakeTextExpression(TextExpressionText,"Technique Text")

  AttachExpression(region.StartStaff,region.StartMeasure,0,TextExpressionID[TextExpressionText])



  --same thing using a description and alternative categories to look in, attach to measure position 2048

  TextExpressionText="Expr2"  

  TextExpressionID[TextExpressionText]=MakeTextExpression(TextExpressionText,"Technique Text",TextExpressionDescription,"Percussion techniques","Percussion")

  AttachExpression(region.StartStaff,region.StartMeasure,2048,TextExpressionID[TextExpressionText])



   --Or as a one-liner with positioning information, attach to measure position 1024

  AttachExpression(region.StartStaff,region.StartMeasure,1024,MakeTextExpression("TextExpressionTextPosition","Technique Text"),140,60)

end