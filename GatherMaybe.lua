function round(num, idp)
   local mult = 10^(idp or 0)
   return math.floor(num * mult + 0.5) / mult
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


SLASH_GATHERM1, SLASH_GATHERM2 = '/gathermaybe', '/gm';
function handler(msg, editbox)
	Gather:Show()
end
SlashCmdList["GATHERM"] = handler;

print("Gather Maybe said:  Reporting for duty sir!")
l = LibStub("LibDraw-1.0")
l.SetWidth(1)
interact = true
blacklist = {}
local newcount
local oldcount
local bltime = GetTime()
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
			if round(delta(px,py,pz,tx,ty,tz),0) <= 6 and playerstill and interact then 
				ObjectInteract(object) 
				blacklisting(object)
				print("Gather Maybe said: Ok, boss that's a nice one!")
			end
			
		
         end
      end
	  oldcount = newcount
end)
l.Enable(0)