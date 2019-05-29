local _, L = ...;
if GetLocale() == "enUS" then


	L["Insert QuestID for info:"] = "";
	L["Check"] = "";
	L["Cancel"] = "";

	L["Quest ID \124cff9d9d9d[%s]\124r %s"] = "";
	L["has already been completed"] = "";
	L["has not yet been completed"] = "";

	L["NO DATABASE INFO FOUND"] = "";

	L[": wrong type value for quest id."] = "";
	L[": quest id out of range."] = "";
	L[": input field null."] = "";


	-- [Options Localization] --
	L[ADDONNAME.." is designed to help user retrieving infos by a quest ID. "
    ..ADDONNAME.." can be useful for example, if you want know what quest"
    .." of a quests chain has not yet completed or if you want find out its title. "
    ..ADDONNAME.." is looking for beta testers to provide feedback for bug fixes and to suggest new features.\n"
    .."Please PM me at "..RnB.LBlue(PM).." if you are want helping or suggesting.\n\r\r"] = "";

    L["Bug Reports"] = "";
	L[RnB.Grey("Please use ")..RnB.WYellow("!BugGrabber")..RnB.Grey(" and ")..RnB.WYellow("BugSack")
	..RnB.Grey(" to provide meaningful information to help me debug without which, "
	.."I probably won't be able to find out, repeat, diagnose, and fix the issue you see).\n\r")] = "";

	L["Features"] = "";
	L["- Keyboard support keys to easy way control UI. "] = "";
	L["[Keys: ESC, Enter]\n"] = "";
	L["- Colored responses"] = "";

	L["Slash Commands"] = "";
	L[" - show the GUI."] = "";

	L["Languages "] = "";

	L["Project Website "] = "";

	L["Developer"] = "Sviluppatore";
	L["Version"] = "";

end