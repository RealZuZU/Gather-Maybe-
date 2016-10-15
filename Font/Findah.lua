local doLoS = false
local showDistance = true

local LibDraw = LibStub("LibDraw-1.0")

local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local losFlags =  bit.bor(0x1, 0x10, 0x100, 0x20000)

local basicMarker = {
	{ 0.1, 0, 0, -0.1, 0, 0},
	{ 0, 0.1, 0, 0, -0.1, 0},
	{ 0, 0, -0.1, 0, 0, 0.1}
}

local lumbermill = {
	texture = "Interface\\Addons\\Findah\\Media\\mill.blp",
	width = 64, height = 64
}
local lumbermill_big = {
	texture = "Interface\\Addons\\Findah\\Media\\mill.blp",
	width = 58, height = 58, scale = 1
}
local lumbermill_small = {
	texture = "Interface\\Addons\\Findah\\Media\\mill.blp",
	width = 18, height = 18, scale = 1
}

local ore = {
	texture = "Interface\\Addons\\Findah\\Media\\ore.blp",
	width = 64, height = 64
}
local ore_big = {
	texture = "Interface\\Addons\\Findah\\Media\\ore.blp",
	width = 58, height = 58, scale = 1
}
local ore_small = {
	texture = "Interface\\Addons\\Findah\\Media\\ore.blp",
	width = 18, height = 18, scale = 1
}

local herb = {
	texture = "Interface\\Addons\\Findah\\Media\\herb.blp",
	width = 64, height = 64
}
local herb_big = {
	texture = "Interface\\Addons\\Findah\\Media\\herb.blp",
	width = 58, height = 58, scale = 1
}
local herb_small = {
	texture = "Interface\\Addons\\Findah\\Media\\herb.blp",
	width = 18, height = 18, scale = 1
}

local fish = {
	texture = "Interface\\Addons\\Findah\\Media\\fish.blp",
	width = 64, height = 64
}
local fish_big = {
	texture = "Interface\\Addons\\Findah\\Media\\fish.blp",
	width = 58, height = 58, scale = 1
}
local fish_small = {
	texture = "Interface\\Addons\\Findah\\Media\\fish.blp",
	width = 18, height = 18, scale = 1
}



local zOffset = 3

LibDraw.Sync(function()
	if FireHack then
		local px, py, pz = ObjectPosition('player')
		local cx, cy, cz = GetCameraPosition()
		local count = ObjectCount()
		for i = 1, count do
			
			local object = ObjectWithIndex(i)
			local guid = UnitGUID(object)
			local objectType, _, _, _, _, _id, _ = strsplit("-", guid)
			local id = tonumber(_id)
			
			if ObjectIsType(object, ObjectTypes.Object) and objectType == 'GameObject'
			and id ~= 234021 and id ~= 234022 and id ~= 234023 then

				local ox, oy, oz = ObjectPosition(object)
				local distance = LibDraw.Distance(px, py, pz, ox, oy, oz)

				local alpha
				local los
				if doLoS then
					los = TraceLine(cx, cy, cz, ox, oy, oz+1, losFlags)
					if los then alpha = 0.25 else alpha = 1 end
				else
					los = false
					alpha = 1
				end

				local name = UnitName(object)

				if id == 234127 or id == 234193 or id == 234023 or id == 234099
				or id == 233634 or id == 237727 or id == 234126 or id == 234111
				or id == 233922 or id == 234128 or id == 234000 or id == 234195
				or id == 234196 or id == 234097 or id == 234198 or id == 234197
				or id == 234123 or id == 234098 or id == 234022 or id == 233604
				or id == 234120 or id == 234194 or id == 234021 or id == 234080
				or id == 234110 or id == 230964 or id == 233635 or id == 234119
				or id == 234122 or id == 234007 or id == 234199 or id == 234124 then
					if distance < 50 then
						LibDraw.Texture(lumbermill_big, ox, oy, oz + zOffset, alpha)
					elseif distance > 200 then
						LibDraw.Texture(lumbermill_small, ox, oy, oz + zOffset, alpha)
					else
						LibDraw.Texture(lumbermill, ox, oy, oz + zOffset, alpha)
					end
					if showDistance then
						LibDraw.SetColorRaw(1, 1, 1, alpha)
						LibDraw.Text(name .. "\n" .. round(distance) .. ' yards', "SystemFont_Tiny", ox, oy, oz + 1)
					end
				end
				
				if id == 228510 or id == 228493 or id == 228564 or id == 228563
				or id == 232544 or id == 232545 or id == 232542 or id == 232543
				or id == 232541 then
					if distance < 50 then
						LibDraw.Texture(ore_big, ox, oy, oz + zOffset, alpha)
					elseif distance > 200 then
						LibDraw.Texture(ore_small, ox, oy, oz + zOffset, alpha)
					else
						LibDraw.Texture(ore, ox, oy, oz + zOffset, alpha)
					end
					if showDistance then
						LibDraw.SetColorRaw(1, 1, 1, alpha)
						LibDraw.Text(name .. "\n" .. round(distance) .. ' yards', "SystemFont_Tiny", ox, oy, oz + 1)
					end
				end

				if id == 237400 or id == 228576 or id == 235391 or id == 237404
				or id == 228574 or id == 235389 or id == 228575 or id == 237406
				or id == 235390 or id == 235388 or id == 228573 or id == 237402
				or id == 228571 or id == 237398 or id == 233117 or id == 235376
				or id == 228991 or id == 235387 or id == 237396 or id == 228572 then
					local ox, oy, oz = ObjectPosition(object)
					if distance < 50 then
						LibDraw.Texture(herb_big, ox, oy, oz + zOffset, alpha)
					elseif distance > 200 then
						LibDraw.Texture(herb_small, ox, oy, oz + zOffset, alpha)
					else
						LibDraw.Texture(herb, ox, oy, oz + zOffset, alpha)
					end
					if showDistance then
						LibDraw.SetColorRaw(1, 1, 1, alpha)
						LibDraw.Text(name .. "\n" .. round(distance) .. ' yards', "SystemFont_Tiny", ox, oy, oz + 1)
					end
				end

				if id == 229072 or id == 229073 or id == 229069 or id == 229068
				or id == 243325 or id == 243354 or id == 229070 or id == 229067
				or id == 236756 or id == 237295 or id == 229071 then
					local ox, oy, oz = ObjectPosition(object)
					if distance < 50 then
						LibDraw.Texture(fish_big, ox, oy, oz + zOffset, alpha)
					elseif distance > 200 then
						LibDraw.Texture(fish_small, ox, oy, oz + zOffset, alpha)
					else
						LibDraw.Texture(fish, ox, oy, oz + zOffset, alpha)
					end
					if showDistance then
						LibDraw.SetColorRaw(1, 1, 1, alpha)
						LibDraw.Text(name .. "\n" .. round(distance) .. ' yards', "SystemFont_Tiny", ox, oy, oz + 1)
					end
				end

			end
		end
	end
end)