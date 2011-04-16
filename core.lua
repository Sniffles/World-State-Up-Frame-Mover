--[[
	WorldStateUpFrame Mover by Sniffles
	
	Credits:
	blooblahguy (move func)
	tekkub (wow ui source)
--]]

if (IsAddOnLoaded("SexyMap")) then return end

local addon = CreateFrame"Frame"
addon:RegisterEvent("ADDON_LOADED")
addon:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") then
		self:UnregisterEvent("ADDON_LOADED")
		print("WorldStateUpFrame Mover is loaded - Use /wmove to move the WorldStateUpFrame")
	end
end)

-- Config
local addonenable = true -- Enable this AddOn?

local font = [[Interface\AddOns\WorldStateUpFrameMover\expresswayfree.ttf]] -- FONT
-- [[Fonts\ARIALN.ttf]] <-- Default Wow Font

local fsize = 12 -- FONTSIZE
local flags = "OUTLINE" -- FONTFLAGS
-- 

if not addonenable == true then return end

local _G = _G
local UIParent = UIParent
local function dummy() end

local function anchor(f, anchor, x, y)
    f:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", })
    f:SetBackdropColor(0, 0, 0, 0)
    f:SetHeight(70)
    f:SetWidth(200)
    f:SetPoint(anchor, UIParent, x, y)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:SetUserPlaced(true)
end

local function SetFontString(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetPoint("TOP", parent)
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1, -1)
	fs:SetText("MOVE ME")
	fs:Hide()
	return fs
end

local function MoveFunc(f)
    if moveit ==1 then
		f:SetBackdropColor(0, 0, 0, 0.7)
		f.text:Show()
        f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", function(self) self:StartMoving() end)
        f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)	
	elseif moveit ==0 then
		f:SetBackdropColor(0, 0, 0, 0)
		f.text:Hide()
        f:SetScript("OnDragStart", function(self) self:StopMovingOrSizing() end)
        f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    end
end

local Wsup = CreateFrame("Frame", "WsupAnchor", UIParent)
anchor(Wsup, "TOP", 0, -20)

Wsup.text = SetFontString(Wsup, font, fsize, flags)

SlashCmdList["MOVEITNAO"] = function()
    if moveit ~=1 then 
		moveit = 1
		print("WorldStateFrame is |cff00ff00unlocked|r")
    else
		moveit = 0
		print("WorldStateFrame is |cffff0000locked|r")
	end
    MoveFunc(Wsup)
end
SLASH_MOVEITNAO1 = "/wmove"

local function WorldStateAlwaysUpFrame_Update()	
	_G["WorldStateAlwaysUpFrame"]:ClearAllPoints()
	_G["WorldStateAlwaysUpFrame"].ClearAllPoints = dummy
	_G["WorldStateAlwaysUpFrame"]:SetPoint("CENTER", Wsup)
	_G["WorldStateAlwaysUpFrame"].SetPoint = dummy
	
	local alwaysUpShown = 1
	
	for i = alwaysUpShown, NUM_ALWAYS_UP_UI_FRAMES do	
		_G["AlwaysUpFrame"..i.."Text"]:SetFont(font, fsize, flags)
	end
end

hooksecurefunc("WorldStateAlwaysUpFrame_Update", WorldStateAlwaysUpFrame_Update)