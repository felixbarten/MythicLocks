local LegionInstanceNames = {
	"Assault on Violet Hold",
	"Black Rook Hold",
	"Eye of Azshara",
	"The Arcway",
	"Court of Stars",
	"Neltharion's Lair",
	"Maw of Souls",
	"Halls of Valor",
	"Darkheart Thicket",
	"Vault of the Wardens",
	"Return to Karazhan",
	"Cathedral of Eternal Night",
	"Seat of the Triumvirate"
}

 local DefaultInstanceNames = {
	 "The Underrot",
	 "The MOTHERLODE!!",
	 "Shrine of the Storm",
	 "Freehold",
	 "Atal'Dazar",
	 "Waycrest Manor",
	 "Siege of Boralis",
	 "Tol Dazor",
	 "Kings' Rest",
	 "Temple of Sethraliss",
 }

SavedOption = false
 
 
SLASH_MYTHICLOCKS1, SLASH_MYTHICLOCKS2, SLASH_MYTHICLOCKS3 = '/mlock', '/mythiclocks', '/locks';
local function handler(msg, editbox)
	local saved = false;
	local expansion = 'bfa';
	if string.find(msg, 'saved') then
		saved = true;
	end

	if string.find(msg, 'legion') then
		expansion = 'legion'
	end 
	print(msg);

	DisplayLocks(saved, expansion);
 end
SlashCmdList["MYTHICLOCKS"] = handler; 
 
 
function DisplayLocks(saved, expansion) 
	local instances = DefaultInstanceNames; 
	if expansion ~= 'bfa' then
		print("Printing for ", expansion);
		instances = LegionInstanceNames;
	end

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

function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end