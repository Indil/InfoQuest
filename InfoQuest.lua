Ver = GetAddOnMetadata(ADDONNAME, "Version")
local f, events, idQuests = CreateFrame("Frame"), {}, {}


--local DEBUG = ADDONNAME.DEBUG
--local expect = ADDONNAME.expect



local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

	-----------------------------
	-- [BEGIN HANDLING EVENTS] --
	-----------------------------
	-- [PLAYER_LOGIN Handler] --

	function events:PLAYER_LOGIN(...)
		print(ADDONNAME .. " v.\124cffffff00" .. Ver .. "\124r properly loaded.") -- Login message
		f:UnregisterEvent("PLAYER_LOGIN")
	end

	-- [CHAT_MSG_ADDON HAndler] --
	--[[
	function events:CHAT_MSG_ADDON(...)
		local msgPrefix, msgMessage, msgType, msgSender = ...;
		if (msgPrefix == "InfoQuest" and msgMessage and msgMessage ~= "") then
			
			print(msgMessage)

		
			local iSlash = string.find(msgMessage,":",1);
			if (iSlash) then
				local sCommand = string.sub(msgMessage,1,iSlash - 1);
				local sValue = string.sub(msgMessage,iSlash + 1);
				if (sCommand == "V" and sValue) then
					-- Version update received
					--GTFO_DebugPrint(msgSender.." sent version info '"..sValue.."' to "..msgType);
					if (not GTFO.Users[msgSender]) then
						GTFO_SendUpdate(msgType);
					end
					GTFO.Users[msgSender] = sValue;
					if ((tonumber(sValue) > GTFO.VersionNumber) and not GTFO.UpdateFound) then
						GTFO.UpdateFound = GTFO_ParseVersionNumber(sValue);
						if (not GTFO.Settings.NoVersionReminder) then
							GTFO_ChatPrint(string.format(GTFOLocal.Loading_OutOfDate, GTFO.UpdateFound));
						end
					end
					return;
				elseif (sCommand == "U" and sValue) then
					-- Version Request
					--GTFO_DebugPrint(msgSender.." requested update to "..sValue);
					GTFO_SendUpdate(sValue);
					return;
				end
			end
			
		end
		return;
	end
	]]--
	

	-- [GETS TITLE QUEST FROM ID] --
	local MyScanningTooltip = CreateFrame("GameTooltip", "MyScanningTooltip", UIParent, "GameTooltipTemplate")

	local QuestTitleFromID = setmetatable({}, { __index = function(t, id)
		MyScanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		MyScanningTooltip:SetHyperlink("quest:"..id)
		local title = MyScanningTooltipTextLeft1:GetText()
		MyScanningTooltip:Hide()
		if title and title ~= RETRIEVING_DATA then
			t[id] = title
			return title
		end
	end })


	local MSG=CreateFrame("MESSAGEFRAME", _, UIParent)
		--MSG:RegisterEvent("UNIT_HEALTH")
		MSG:SetWidth(900)
		MSG:SetHeight(80)
		MSG:SetPoint("CENTER", 0, 200)
		--MSG:SetFont("Interface\\Addons\\"..ADDONNAME.."\\fonts\\Carlito-Bold.ttf", 22, "OUTLINE")
		MSG:SetFont("Interface\\Addons\\"..ADDONNAME.."\\fonts\\Carlito-Regular.ttf", 22, "OUTLINE")
		MSG:SetInsertMode("BOTTOM")
		MSG:SetFadeDuration(1)
		MSG:SetFading("ON")
		MSG:SetTimeVisible(6)


	--[[

		TO DEVELOPE for MULTI-INPUT PURPOSE
	-------------------------------------------
	-- [Populates the table of QUESTS lists] --
    
    function mInsertIDs(v)
	    for i,v in ipairs(v) do
	      idQuests[v] = i
	    end
	end
	
	-- [MULTI-OUTPUT ROUTINE TO FIND OUT INFOS OF QUESTS] --
	
		function mPrintQ(idQuests)
			for k,v in pairs(idQuests) do
				-- DO SOMETHING
			end
		end

	]]--


		--------------------------------
		-- [ERRORS HANDLING FUNCTION] --
		--------------------------------
		function check(idQ)

			if idQ ~= "" then
				
				local n = tonumber(idQ)
			    
			    if n == nil then -- ID is not a number
			        --error("wrong type value for quest id", 2)
			        print("\124cffff7d0a["..ADDONNAME.."\124r]"..L[": wrong type value for quest id."])
			    else
			    	local FC, LC = string.find(idQ, idQ) -- FIRST AND LAST CHAR POSITIONS

				    if LC > 5 then -- range limit for QUESTS IDS setted to 99999
				        --error("quest id input does not exist", 2)
				        print("\124cffff7d0a["..ADDONNAME.."\124r]"..L[": quest id out of range."])
				    else
				    	return true
				    end
			    end

			else
				--error("input field null", 2)
				print("\124cffff7d0a["..ADDONNAME.."\124r]"..L[": input field null."])
			end

			-- ISSUE WHEN NOT FIND ERROR (on lua errors handling)
		end

		

	function printQ(idQ)
		
		MSG:Show()		
		QTitle = QuestTitleFromID[idQ]


		if QTitle then -- Title Quest found on server database

			if IsQuestFlaggedCompleted(idQ) then
				--print(format(ADDONNAME..": \124cff9d9d9d[%s]\124r %s", QTitle, "has already been completed"))
				COLOR = TBLColors["Green"]
				infoQ = format("\124cff9d9d9d%s\124r %s", QTitle, L["has already been completed"])
				--print (infoQ)
			else
				--print(format(ADDONNAME..": \124cff9d9d9d[%s]\124r %s", QTitle, "has not yet been completed")
				COLOR = TBLColors["Orange"]
				infoQ = format("\124cff9d9d9d%s\124r %s", QTitle, L["has not yet been completed"])
				--print (infoQ)
			end

		else -- Title Quest not found on server database
			
			if IsQuestFlaggedCompleted(idQ) then
				COLOR = TBLColors["WYellow"]
				r,g,b = ColorToRGB(COLOR)
				MSG:AddMessage(L["NO DATABASE INFO FOUND"], r,g,b, 10, 6)
				
				COLOR = TBLColors["Green"]
				infoQ = format(L["Quest ID \124cff9d9d9d[%s]\124r %s"], idQ, L["has already been completed"])
			else
				COLOR = TBLColors["WYellow"]
				r,g,b = ColorToRGB(COLOR)
				MSG:AddMessage(L["NO DATABASE INFO FOUND"], r,g,b, 10, 6)
				
				COLOR = TBLColors["Red"]
				infoQ = format(L["Quest ID \124cff9d9d9d[%s]\124r %s"], idQ, L["has not yet been completed"])
			end
		end
		
		r,g,b = ColorToRGB(COLOR)
		MSG:AddMessage(infoQ, r,g,b, 10, 6)

		MSGLOADED = true
	end

	
	-- [Input for Quest ID] --
	StaticPopupDialogs["SetVariable"] = {
		text = L["Insert QuestID to get info:"],
		button1 = L["Check"],
		--button3 = L["Set by UnitId"],
		button2 = L["Cancel"],
		hasEditBox = 1,
		whileDead = 1,
		hideOnEscape = 1,
		timeout = 0,
		--enterClicksFirstButton = function(self) self:GetParent().button1:Click() end,
		enterClicksFirstButton = 1,
		EditBoxOnEnterPressed = function(self) self:GetParent().button1:Click() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,

		OnShow = function(self, data)
			
			if idQ then
				self.editBox:SetText(idQ)
				self.editBox:HighlightText()
			else
				self.editBox:SetText("")
				self.editBox:SetFocus()
			end
			
			self.button1:Disable()
		end,
		OnAccept = function(self, data, data2)
			
			idQ = self.editBox:GetText()
			--local status, err = pcall(check(idQ))

			--if err then
			if check(idQ) then
			    -- no errors while running `foo'
				printQ(idQ)
		    
		    end
				-- `foo' raised an error: take appropriate actions
					
				--print(err)
				
		    --end

		end,
		--OnAlt = function()
		--  variable = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		--  MTarget:SetTargetByUnitId(variable, MTarget.currentTarget);
		--end
		EditBoxOnTextChanged = function (self, data) -- careful! 'self' here points to the editbox, not the dialog
		    if self:GetText() ~= "" then
		    	self:GetParent().button1:Enable()    -- self:GetParent() is the dialog
		    else
		    	self:GetParent().button1:Disable()
		    end
		end
	}


	-- [REGISTERS ALL EVENTS NEEDED FOR ADDON] --
	f:SetScript("OnEvent", function(self, event, ...)
		events["PLAYER_LOGIN"](self, ...) -- call one of the functions above
		--events["CHAT_MSG_ADDON"](self, ...)
	end)

	for k, v in pairs(events) do
		f:RegisterEvent(k) -- Register all events for which handlers have been defined
	end


	SLASH_INFOQUEST1 = "/infoq"
	SLASH_INFOQUEST2 = "/infoquest"
	SlashCmdList["INFOQUEST"] = function(msg)
		
		if MSGLOADED then
			MSG:Hide()
			MSG:Clear()
			QTitle = nil
			MSGLOADED = nil
		end

		StaticPopup_Show("SetVariable")
	end