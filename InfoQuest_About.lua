local AceConfig = LibStub("AceConfig-3.0", true)
-- GetAddOnInfo returns basic information about an addon.
-- GetAddOnMetadata returns information listed in a specified .toc tag.
-- GetBuildInfo returns the client's interface version.


    if not AceConfig then
        message(("InfoQuest requires the library %q and will not work without it."):format("AceConfig-3.0"))
        error(("InfoQuest requires the library %q and will not work without it."):format("AceConfig-3.0"))
    end


local AceConfigDialog = LibStub("AceConfigDialog-3.0")


AceConfig:RegisterOptionsTable("InfoQuest_Bliz", {
    name = ADDONNAME,
    handler = InfoQuestOpt,
    type = 'group',
        args = {

            info = {
                name = L[ADDONNAME.." is designed to help user retrieving infos by a quest ID. "
                ..ADDONNAME.." can be useful for example, if you want know what quest"
                .." of a quests chain has not yet completed or if you want find out its title. "
                ..ADDONNAME.." is looking for beta testers to provide feedback for bug fixes and to suggest new features.\n"
                .."Please PM me at "..RnB.LBlue(PM).." if you are want helping or suggesting.\n\r\r"],
                fontSize = 'medium',
                type = 'description',
                width = 'double',
                order = 2,
            },
            title1 = {
                name = RnB.WYellow(L["Bug Reports"]),
                fontSize = 'large',
                type = 'description',
                order = 5
            },
            info1 = {
                name = L[RnB.Grey("Please use ")..RnB.WYellow("!BugGrabber")..RnB.Grey(" and ")..RnB.WYellow("BugSack")
                ..RnB.Grey(" to provide meaningful information to help me debug without which, "
                .."I probably won't be able to find out, repeat, diagnose, and fix the issue you see).\n\r")],
                fontSize = 'medium',
                type = 'description',
                order = 10
            },
            title2 = {
                name = RnB.WYellow(L["Features"]),
                fontSize = 'large',
                type = 'description',
                order = 15
            },
            info2 = {
                name = "        "..RnB.Grey(L["- Keyboard support keys to easy way control UI. "])..RnB.WYellow(L["[Keys: ESC, Enter]\n"])
                    .."        "..RnB.Grey(L["- Colored responses"]).."\n\r",
                fontSize = 'medium',
                type = 'description',
                order = 20
            },
            title3 = {
                name = RnB.WYellow(L["Slash Commands"]),
                fontSize = 'large',
                type = 'description',
                order = 25
            },
            info3 = {
                name = "     "..RnB.Green("/infoq, /infoquest")..RnB.Grey(L[" - show the GUI."]).."\n\r",
                fontSize = 'medium',
                type = 'description',
                order = 30
            },
            spacing1 = { -- blank image for spacing elements 60px

                name = "",
                type = 'description',
                order = 35,
                image = "Interface\\Addons\\"..ADDONNAME.."\\media\\blank.tga",
                imageHeight = 60
            },
            info4 = {
                name = RnB.WYellow(L["Languages "])..LANGS,
                --fontSize = 'medium',
                type = 'description',
                order = 40
            },
            info5 = {
                name = RnB.WYellow(L["Project Website "])..RnB.LBlue(WEB),
                --fontSize = 'medium',
                type = 'description',
                order = 50
            },
            spacing2 = { -- blank image for spacing elements 30px

                name = "",
                type = 'description',
                order = 60,
                image = "Interface\\Addons\\"..ADDONNAME.."\\media\\blank.tga",
                imageHeight = 30
            },
            developer = {
                name = RnB.Grey(L["Developer"]..": "..OWNER),
                --fontSize = 'medium',
                type = 'description',
                order = 90
            },
            version = {
                name = L["Version"]..": "..Ver,
                --fontSize = 'medium',
                type = 'description',
                order = 100
            }

    },
})
AceConfigDialog:AddToBlizOptions("InfoQuest_Bliz", ADDONNAME)

