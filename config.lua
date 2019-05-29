-- [BEGIN GLOBAL VARIABLES SETTINGS] --
ADDONNAME, L = ...
OWNER = GetAddOnMetadata(ADDONNAME, "Author").." [IT]"
WEB = GetAddOnMetadata(ADDONNAME, "X-Website")
LANGS = GetAddOnMetadata(ADDONNAME, "X-Localizations")
PM = GetAddOnMetadata(ADDONNAME, "X-PM")
-- [END GLOBAL VARIABLES SETTINGS] --


-- [BEGIN STRING COLORS CONVERSION] --
		
	HEXc = {

		aa = "00ff00", 	--Green
		ab = "ff0000",	--Red
		ac = "ffff00",	--Yellow
		ad = "ff7d0a",	--Orange
		ae = "4499ff",	--LBLue
		af = "aaaaaa",	--Grey
		ag = "f8b700"	--WYellow
	}
	

	function setDefault (t, d)
      local mt = {__index = function () return d end}
      setmetatable(t, mt)
    end

	setDefault(HEXc, "ffffff") -- DEFAULT VALUE RNB WHITE



	function HEX2RGB(hx) -- Esadecimal to RGB conversion
		
		local r = string.sub(hx, 1, 2)
 		local g = string.sub(hx, 3, 4)
		local b = string.sub(hx, 5, 6)

		
		local r = (tonumber(r,16) / 255)
		local fr = math.floor(r * 1000 + 0.5) / 1000
		
			
			if string.len(fr) == 4 then
				fr = tostring(fr).."0"
			elseif string.len(fr) == 3 then
				fr = tostring(fr).."00"
			elseif string.len(fr) == 1 then
				fr = tostring(fr)..".000"
			end
		

		local g = (tonumber(g,16) / 255)
		local fg = math.floor(g * 1000 + 0.5) / 1000
		
			
			if string.len(fg) == 4 then
				fg = tostring(fg).."0"
			elseif string.len(fg) == 3 then
				fg = tostring(fg).."00"
			elseif string.len(fg) == 1 then
				fg = tostring(fg)..".000"
			end

		
		local b = (tonumber(b,16) / 255)
		local fb = math.floor(b * 1000 + 0.5) / 1000
		

			
			if string.len(fb) == 4 then
				fb = tostring(fb).."0"
			elseif string.len(fb) == 3 then
				fb = tostring(fb).."00"
			elseif string.len(fb) == 1 then
				fb = tostring(fb)..".000"
			end



		return tostring(fr..fg..fb)
	end


	--print(HEX2RGB(HEXc.ac))


	RnB = {

		Green = function (txt)
    		CLRT = format("|cff"..HEXc.aa..txt.."|r")
    		return CLRT
		end,

		Red = function (txt)
    		CLRT = format("|cff"..HEXc.ab..txt.."|r")
    		return CLRT
		end,

		Yellow = function (txt)
    		CLRT = format("|cff"..HEXc.ac..txt.."|r")
    		return CLRT
		end,

		Orange = function (txt)
    		CLRT = format("|cff"..HEXc.ad..txt.."|r")
    		return CLRT
		end,

		LBlue = function (txt)
    		CLRT = format("|cff"..HEXc.ae..txt.."|r")
    		return CLRT
		end,

		Grey = function (txt)
    		CLRT = format("|cff"..HEXc.af..txt.."|r")
    		return CLRT
		end,

		WYellow = function (txt)
    		CLRT = format("|cff"..HEXc.ag..txt.."|r")
    		return CLRT
		end,

	}
	

	setDefault(RnB, function (txt) -- DEFAULT VALUE RNB WHITE
		
		CLRT = format("|cff"..HEXc.xx..txt.."|r")
		
		return CLRT
	end)

-- [END STRINGS COLORS CONVERSION] --

-- [BEGIN RGB COLORS CONVERSION] --
		
	TBLColors = {
		["Green"] = HEX2RGB(HEXc.aa), ["Red"] = HEX2RGB(HEXc.ab),
		["Yellow"] = HEX2RGB(HEXc.ac), ["Orange"] = HEX2RGB(HEXc.ad),
		["LBlue"] = HEX2RGB(HEXc.ae), ["Grey"] = HEX2RGB(HEXc.af),
		["WYellow"] = HEX2RGB(HEXc.ag)
	}
	
	function ColorToRGB(sCOLOR)
		R = tonumber(string.sub(sCOLOR, 1, 5))
 		G = tonumber(string.sub(sCOLOR, 6, 10))
		B = tonumber(string.sub(sCOLOR, 11, 15))

		return R,G,B
	end

-- [END RGB COLOR CONVERSION] --