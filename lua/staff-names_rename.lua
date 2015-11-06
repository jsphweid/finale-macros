function plugindef()
    finaleplugin.Author = "Jari Williamsson, modified by Joseph Weidinger"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "July 02, 2015"
    finaleplugin.RequireSelection = false
    finaleplugin.CategoryTags = "staff names"
    return "Staff Names - Rename", "Staff Names - Rename", "Change staff names to the more succinct convention"
end


-- written by Jari Williamsson and modified by me.
function ChangeStaffInstruments(thestring)
    if thestring:ContainsLuaString("^flat()", nil) then
        thestring:Replace("Clarinet in E^flat()", "E^flat() Clarinet")
        thestring:Replace("Clarinet in B^flat()", "B^flat() Clarinet") 
        thestring:Replace("Alto Clarinet", "E^flat() Alto Clarinet")
        thestring:Replace("Bass Clarinet", "B^flat() Bass Clarinet")    
        thestring:Replace("Contralto Clarinet", "E^flat() Contrabass Clarinet")    
        thestring:Replace("Contrabass Clarinet", "B^flat() Contrabass Clarinet")
        thestring:Replace("Sopranino Sax", "E^flat() Sopranino Saxophone")
        thestring:Replace("Soprano Sax", "B^flat() Soprano Saxophone")
        thestring:Replace("Alto Sax", "E^flat() Alto Saxophone")
        thestring:Replace("Tenor Sax", "B^flat() Tenor Saxophone")
        thestring:Replace("Baritone Sax", "E^flat() Baritone Saxophone")
        thestring:Replace("Bass Sax", "B^flat() Bass Saxophone")
        thestring:Replace("Contrabass Sax", "E^flat() Contrabass\rSaxophone")
        thestring:Replace("SubContrabass Sax", "B^flat() Subcontrabass\rSaxophone")
        thestring:Replace("Trumpet in B^flat()", "B^flat() Trumpet")
        thestring:Replace("Horn in E^flat()", "E^flat() Horn")
        thestring:Replace("Horn in F", "F Horn")    
        thestring:Replace("Baritone (B.C.)", "Baritone BC")
        thestring:Replace("Baritone (T.C.)", "Baritone TC")
    end
end

function ParseStaves()
    -- Load all staves
    local staves = finale.FCStaves()
    staves:LoadAll()
    -- Parse through the staves
    for staff in each(staves) do    
        local oldstring = staff:CreateFullNameString()
        local staffstring = staff:CreateFullNameString()

        -- prepare it
        if staffstring:ContainsLuaString("Bb", nil) then
            staffstring:Replace("Bb", "B^flat()")
        end
        
        -- Change the instrument texts
        ChangeStaffInstruments(staffstring)
        -- If the text has changed, save the string
        if oldstring.LuaString ~= staffstring.LuaString then
            staff:SaveFullNameString(staffstring)
        end    
    end
end

ParseStaves()
