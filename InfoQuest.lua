local f, events, idQuests = CreateFrame("Frame"), {}, {}
local ADDONNAME, L = ...
local Ver = GetAddOnMetadata(ADDONNAME, "Version")
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
	  -- PLAYER_LOGIN Handler --

	function events:PLAYER_LOGIN(...)
		print(ADDONNAME .. " v.\124cffffff00" .. Ver .. "\124r properly loaded.") -- Login message
	end



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



	-- [Populates the table of QUESTS lists] --
    function mInsertIDs(v)
	    for i,v in ipairs(v) do
	      idQuests[v] = i
	    end
	end

	-- [MULTI-OUTPUT ROUTINE OF INFO ON QUESTS COMPLETED OR NOT] --
	--[[
		function mPrintQ(idQuests)
			for k,v in pairs(idQuests) do
				print(format("%s: |cff%s|r", k, IsQuestFlaggedCompleted(v) and "00ff00Yes" or "ff0000No"))
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

			-- PROBLEM WHEN NOT FIND ERROR
		end

		

	function printQ(idQ)
		
		MSG:Show()		
		QTitle = QuestTitleFromID[idQ]

		
		-- [BEGIN TABLE COLORS CONVERSION] --
		
			TBLColors = {["Green"] = "0.001.000.00", ["Red"] = "1.000.000.00",
				["Yellow"] = "1.001.000.00", ["Orange"] = "1.000.490.04"}
			
			function ColorToRGB(sCOLOR)
				R = tonumber(string.sub(COLOR, 1, 4))
		 		G = tonumber(string.sub(COLOR, 5, 8))
				B = tonumber(string.sub(COLOR, 9, 12))

				return R,G,B
			end
		-- [END TABLE COLOR CONVERSION] --

		if QTitle then -- Title Quest found on server database

			if IsQuestFlaggedCompleted(idQ) then
				--print(format(ADDONNAME..": \124cff9d9d9d[%s]\124r %s", QTitle, "has already been completed"))
				COLOR = TBLColors["Green"]
				infoQ = format(L["\124cff9d9d9d%s\124r %s"], QTitle, L["has already been completed"])
				print (infoQ)
			else
				--print(format(ADDONNAME..": \124cff9d9d9d[%s]\124r %s", QTitle, "has not yet been completed")
				COLOR = TBLColors["Orange"]
				infoQ = format(L["\124cff9d9d9d%s\124r %s"], QTitle, L["has not yet been completed"])
				print (infoQ)
			end

		else -- Title Quest not found on server database
			
			if IsQuestFlaggedCompleted(idQ) then
				COLOR = TBLColors["Yellow"]
				r,g,b = ColorToRGB(COLOR)
				MSG:AddMessage(L["NO DATABASE INFO FOUND"], r,g,b, 10)
				
				COLOR = TBLColors["Green"]
				infoQ = format(L["Quest ID \124cff9d9d9d[%s]\124r %s"], idQ, L["has already been completed"])
			else
				COLOR = TBLColors["Yellow"]
				r,g,b = ColorToRGB(COLOR)
				MSG:AddMessage(L["NO DATABASE INFO FOUND"], r,g,b, 10)
				
				COLOR = TBLColors["Red"]
				infoQ = format(L["Quest ID \124cff9d9d9d[%s]\124r %s"], idQ, L["has not yet been completed"])
			end
		end
		
		--print(R..","..G..","..B)
		r,g,b = ColorToRGB(COLOR)
		MSG:AddMessage(infoQ, r,g,b, 10)

		MSGLOADED = 1
	end

	f:SetScript("OnEvent", function(self, event, ...)
		events["PLAYER_LOGIN"](self, ...) -- call one of the functions above
	end)

	for k, v in pairs(events) do
		f:RegisterEvent(k) -- Register all events for which handlers have been defined
	end


	-- [Input for Quest ID] --
	StaticPopupDialogs["SetVariable"] = {
		text = L["Insert QuestID for info:"],
		button1 = L["OK"],
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
		    	self:GetParent().button1:Enable()       -- self:GetParent() is the dialog
		    else
		    	self:GetParent().button1:Disable()
		    end
		end
	}



	SLASH_INFOQUEST1 = "/infoq"
	SLASH_INFOQUEST2 = "/infoquest"
	SlashCmdList["INFOQUEST"] = function(msg)
		
		if MSGLOADED then
			MSG:Hide()
			QTitle = nil
		end

		StaticPopup_Show("SetVariable")
	end