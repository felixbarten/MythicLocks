local LegionInstanceIDs = {777, 740, 716, 726, 800, 767, 727, 721, 762, 707, 860, 900, 945}
local BFAInstanceIDs = {968, 1001, 1041, 1036, 1023, 1030, 1012, 1022, 1002, 1021}

local LegionInstanceNames = {}
local DefaultInstanceNames = {}

-- Retrieve dungeon names from instance identifiers using Encounter Journal. 
-- Thanks Candesco for the suggestion!
-- https://www.curseforge.com/wow/addons/mythiclocks?comment=6
function FillInstances()
	for k, v in pairs(BFAInstanceIDs) do 
		local name, _, _, _, _, _, _ = EJ_GetInstanceInfo(v)
		table.insert(DefaultInstanceNames, name)
	end 

	for k, v in pairs(LegionInstanceIDs) do
		local name, _, _, _, _, _, _ = EJ_GetInstanceInfo(v)
		table.insert(LegionInstanceNames, name)
	end
end
FillInstances()
SavedOption = false
 
SLASH_MYTHICLOCKS1, SLASH_MYTHICLOCKS2, SLASH_MYTHICLOCKS3 = '/mlock', '/mythiclocks', '/locks';
local function handler(msg, editbox)
	local saved = false;
	local expansion = 'bfa';
	if string.find(msg, 'saved') then
		saved = true;
	end

	if string.find(msg, 'legion') then
		expansion = 'legion';
	end 
	print(msg);

	DisplayLocks(saved, expansion);
end
SlashCmdList["MYTHICLOCKS"] = handler; 
 
 
function DisplayLocks(saved, expansion) 
	local instances = SelectExpansion(expansion)

	if saved == true then
		print("You are saved in the following Mythic dungeons:")
	end

	for i =1, GetNumSavedInstances() do
		local name, _, _, _, locked, extended, _, _, _, difficultyName, _, _
		 = GetSavedInstanceInfo(i)

		if difficultyName == "Mythic" then
			
			for k, v in pairs(instances) do 
				if name == v then
					if locked == true then
						-- if saved option
						--print (SavedOption)
						if saved == true then 
							print("You are saved to: |cffff0000", v)
						end
						table.remove(instances, k)
					end 
				end
			end
		end
		
	end 
	print("You are eligible for the following ", tableLength(instances), " Mythic Dungeons")	
	for k,v in pairs(instances) do 
		print ("You are not saved in: |cFF00FF00",v)
	end
end

function SelectExpansion(expansion) 
	local instanceTable = {}
	if expansion ~= 'bfa' then
		print("Printing for ", expansion)
		instanceTable = deepcopy(LegionInstanceNames)
	else 
		instanceTable = deepcopy(DefaultInstanceNames)
	end 
	return instanceTable
end

function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

-- Using deepcopy on our Table of dungeon names so subsequent executions of the addon don't break. 
-- Deepcopy implementation from LUA wiki
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end