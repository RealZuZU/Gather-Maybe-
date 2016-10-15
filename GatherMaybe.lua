print("Gather Maybe said:  Reporting for duty sir!")
l = LibStub("LibDraw-1.0")
l.SetWidth(1)
blacklist = {}
local newcount
local oldcount
local bltime = GetTime()
togglecheck = 0;

function round(num, idp)
   local mult = 10^(idp or 0)
   return math.floor(num * mult + 0.5) / mult
end
function clear(list)
   for k in pairs (list) do
      list [k] = nil
   end
end
function delta(x1, y1, z1, x2, y2, z2)
   local dx = x1 - x2
   local dy = y1 - y2
   local dz = z1 - z2
   result = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))
   return result
end

function blacklisted(object)
	for i = 1, table.getn(blacklist) do
		if blacklist[i] == object then return true end
	end
	return false
end

function blacklisting(object)
	table.insert(blacklist, object)
	bltime = GetTime()
end






local Gather = CreateFrame("frame","GatherFrame")
Gather:SetBackdrop({
      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
      tile=1, tileSize=32, edgeSize=32, 
      insets={left=11, right=12, top=12, bottom=11}
})
Gather:SetWidth(250)
Gather:SetHeight(100)
Gather:SetPoint("CENTER",UIParent)
Gather:EnableMouse(true)
Gather:SetMovable(true)
Gather:RegisterForDrag("LeftButton")
Gather:SetScript("OnDragStart", function(self) self:StartMoving() end)
Gather:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
Gather:SetFrameStrata("FULLSCREEN_DIALOG")

local Title = CreateFrame("Frame", nil, Gather)
Title:SetPoint("TOPLEFT", 0, -10)
Title:SetPoint("TOPRIGHT", 0, -10)
Title:SetHeight(10)

local TitleText = Title:CreateFontString();
TitleText:SetAllPoints(Title);
	TitleText:SetFont("Fonts\\FRIZQT__.TTF", 10)

TitleText:SetText("Gather Maybe?");
TitleText:SetJustifyH("CENTER");
local CloseButton = CreateFrame("Button", nil, Title, "UIPanelCloseButton");
			CloseButton:SetPoint("TOPRIGHT", -5, 5);
			CloseButton:SetHeight(18);
			CloseButton:SetWidth(18);
			CloseButton:SetScript("OnClick", function () Gather:Hide(); end);

			
local button = CreateFrame("button","GatherButton", Gather, "UIPanelButtonTemplate")
button:SetHeight(24)
button:SetWidth(60)
button:SetPoint("BOTTOM", Gather, "BOTTOM", 0, 10)
button:SetText("Disabled")
button:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") 
if togglecheck == 0 then
		print("Enabled")
		button:SetText("Enabled")
        togglecheck = 1;
l.Sync(function()
	if GetTime() - bltime >= 20 then 
		clear(blacklist)
		bltime = GetTime()
	end

	newcount = ObjectCount()
      for i = 1, ObjectCount() do
         local name = ObjectName(ObjectWithIndex(i))
         local object = ObjectWithIndex(i)
         local px, py, pz = ObjectPosition("player")
         local tx, ty, tz = ObjectPosition(object)
		 local playerstill = UnitMovementFlags(ObjectPointer("player")) == 0
         if ObjectType(object) == 33 and ObjectExists(object) and not blacklisted(object) then 
			if round(delta(px,py,pz,tx,ty,tz),0) <= 6 and playerstill then 
				ObjectInteract(object) 
				blacklisting(object)
				print("Gather Maybe said: Ok, boss that's a nice one!")
			end
			
		
         end
      end
	  oldcount = newcount
end)
l.Enable(0)
    elseif togglecheck == 1 then
		print("Disabled")
		button:SetText("Disabled")
        togglecheck = 0;
    end

  end)

  
  SLASH_GATHERM1, SLASH_GATHERM2 = '/gathermaybe', '/gm';
function handler(msg, editbox)
	Gather:Show()
end
SlashCmdList["GATHERM"] = handler;
