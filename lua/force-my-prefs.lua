function plugindef()
    finaleplugin.Author = "Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "change default preferences for page"
    return "Force Joseph's Part/Score Preferences", "Force Joseph's Part/Score Preferences", "Change to my Default Page Prefs"
end

-- Parts
local partPrefs = finale.FCPageFormatPrefs()
partPrefs:LoadParts()
partPrefs.FirstPageTopMargin = 792 -- 792 EVPUs is 2.4 Inches
partPrefs.FirstSystemDistance = 0
partPrefs.FirstSystemLeft = 144 -- 144 EVPUs is .5 inch
partPrefs.FirstSystemTop = 380
partPrefs.LeftPageBottomMargin = 144 -- 144 EVPUs is .5 inch
partPrefs.LeftPageLeftMargin = 144 -- 144 EVPUs is .5 inch
partPrefs.LeftPageRightMargin = 144 -- 144 EVPUs is .5 inch
partPrefs.LeftPageTopMargin = 346 -- 346 is 1.2 Inches
partPrefs.PageHeight = 3456 --3456 EVPUs is 12 Inches
partPrefs.PageScaling = 100 -- %
partPrefs.PageWidth = 2592 -- 2592 EVPUs is 9 Inches
-- partPrefs.RightPageBottomMargin = 144 -- 144 EVPUs is .5 inch
-- partPrefs.RightPageLeftMargin = 180 -- 180 EVPUs is .625 inch
-- partPrefs.RightPageRightMargin = 144 -- 144 EVPUs is .5 inch
-- partPrefs.RightPageTopMargin = 144 -- 144 EVPUs is .5 inch
partPrefs.SystemBottom = 96 -- 96 EVPUs is 1/3 inch
partPrefs.SystemDistanceBetween = 0
partPrefs.SystemLeft = 0
partPrefs.SystemRight = 0
partPrefs.SystemScaling = 100 -- %
partPrefs.SystemStaffHeight = 1536 -- this is 96 EVPU's but it is actually 16 times that because of the notation
partPrefs.SystemTop = 0
partPrefs.UseFacingPages = false -- would eliminate some values above but what the hell
partPrefs.UseFirstPageTopMargin = true
partPrefs.UseFirstSystemMargins = false
partPrefs:Save()

-- Score
local scorePrefs = finale.FCPageFormatPrefs()
scorePrefs:LoadScore()
scorePrefs.FirstPageTopMargin = 792 -- 792 EVPUs is 2.4 Inches
scorePrefs.FirstSystemDistance = 0
scorePrefs.FirstSystemLeft = 173 -- 173 EVPUs is .6 inch
scorePrefs.FirstSystemTop = 0
scorePrefs.LeftPageBottomMargin = 144 -- 144 EVPUs is .5 inch
scorePrefs.LeftPageLeftMargin = 259 -- 259 EVPUs is .9 inch
scorePrefs.LeftPageRightMargin = 144 -- 144 EVPUs is .5 inch
scorePrefs.LeftPageTopMargin = 432 -- 432 is 1.5 Inches
scorePrefs.PageHeight = 4896 --4896 EVPUs is 17 Inches
scorePrefs.PageScaling = 100 -- %
scorePrefs.PageWidth = 3168 -- 3168 EVPUs is 11 Inches
-- scorePrefs.RightPageBottomMargin = 144 -- 144 EVPUs is .5 inch
-- scorePrefs.RightPageLeftMargin = 180 -- 180 EVPUs is .625 inch
-- scorePrefs.RightPageRightMargin = 144 -- 144 EVPUs is .5 inch
-- scorePrefs.RightPageTopMargin = 144 -- 144 EVPUs is .5 inch
scorePrefs.SystemBottom = 0
scorePrefs.SystemDistanceBetween = 0
scorePrefs.SystemLeft = 0
scorePrefs.SystemRight = 0
scorePrefs.SystemScaling = 100 -- %
scorePrefs.SystemStaffHeight = 1536 -- this is 96 EVPU's but it is actually 16 times that because of the notation
scorePrefs.SystemTop = 0
scorePrefs.UseFacingPages = false -- would eliminate some values above but what the hell
scorePrefs.UseFirstPageTopMargin = true
scorePrefs.UseFirstSystemMargins = true
scorePrefs:Save()