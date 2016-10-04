local InstanceNames = {"Assault on Violet Hold",
 "Black Rook Hold", "Eye of Azshara", "The Arcway",
 "Court of Stars", "Neltharion's Lair", 
 "Maw of Souls", "Halls of Valor", 
 "Darkheart Thicket", "Vault of the Wardens"}

SavedOption = false
 
 
SLASH_MYTHICLOCKS1, SLASH_MYTHICLOCKS2, SLASH_MYTHICLOCKS3 = '/mlock', '/mythiclocks', '/locks';
local function handler(msg, editbox)
	if msg == 'saved' then
		DisplayLocks(true)
	else
		DisplayLocks(false)
	end
end
SlashCmdList["MYTHICLOCKS"] = handler; 
 
 
function DisplayLocks(saved) 
	if saved == true then
		print("You are saved in the following Mythic dungeons:")
	end

	for i =1, GetNumSavedInstances() do
		local name, _, _, _, locked, extended, _, _, _, difficultyName, _, _
		 = GetSavedInstanceInfo(i)

		if difficultyName == "Mythic" then
			
			for k, v in pairs(InstanceNames) do 
				if name == v then
					if locked == true then
						-- if saved option
						--print (SavedOption)
						if saved == true then 
							print("You are saved to: |cffff0000", v)
						end
						table.remove(InstanceNames, k)
					end 
				end
			end
		end
		
	end 
	print("You are not saved to the following Mythic dungeons:")	
	for k,v in pairs(InstanceNames) do 
		print ("You are not locked to: |cFF00FF00",v)
	end
	
end