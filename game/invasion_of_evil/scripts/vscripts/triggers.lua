--outputid
--caller
--activator


function TeleportTrigger(data)
	--print("TeleportTrigger")
	if PORTAL_OW_EXIST == true then
		local point = Entities:FindByName( nil, "hero_teleport_spawner"):GetAbsOrigin()
		local activator = data.activator

		activator:SetAbsOrigin(point) 
		FindClearSpaceForUnit(activator, point, false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
	end
end


function TeleportHome(data)
	--print("TeleportTrigger")
	local activator = data.activator
    activator:RespawnHero(false, false)
    main:FocusCameraOnPlayer(activator)
end

function TeleportTriggerDungJeepers(data)
	--print("TeleportTriggerDungJeepers")
	local activator = data.activator
	local modifier = activator:FindModifierByName("modifier_quest_dungeon_jeepers") or nil

	if not modifier then
		return nil
	end

	if modifier:GetStackCount() >= CHARGES_FOR_JEEPERS_DUNG  then
		activator:SetAbsOrigin(Entities:FindByName( nil, "dungeon_jeepers_hero_spawner"):GetAbsOrigin()) 
		FindClearSpaceForUnit(activator, activator:GetAbsOrigin(), false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
		modifier:SetStackCount(0)
	end	

end


function TeleportTriggerDungCursed(data)
	--print("TeleportTriggerDungCursed")
	local activator = data.activator
	local modifier = activator:FindModifierByName("modifier_quest_dungeon_cursed") or nil

	if not modifier then
		return nil
	end

	if modifier:GetStackCount() >= CHARGES_FOR_CURSED_DUNG  then
		activator:SetAbsOrigin(Entities:FindByName( nil, "dungeon_cursed_hero_spawner"):GetAbsOrigin()) 
		FindClearSpaceForUnit(activator, activator:GetAbsOrigin(), false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
		modifier:SetStackCount(0)
	end	
end
