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


function TeleportTriggerCellar(data)
	--print("TeleportTrigger")
	local caller = data.caller:GetName()
	local point = Entities:FindByName( nil, "cellar_hero_spawner_1"):GetAbsOrigin()
	local activator = data.activator

	if caller == "trigger_teleport_to_cellar_1" then
		point = Entities:FindByName( nil, "cellar_hero_spawner_1"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_to_cellar_2" then
		point = Entities:FindByName( nil, "cellar_hero_spawner_2"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_to_cellar_3" then
		point = Entities:FindByName( nil, "cellar_hero_spawner_3"):GetAbsOrigin()
	end

	activator:SetAbsOrigin(point) 
	FindClearSpaceForUnit(activator, point, false) 
	activator:Stop()
	main:FocusCameraOnPlayer(activator)
end


function TeleportTriggerFromCellar(data)
	--print("TeleportTrigger")
	local caller = data.caller:GetName()
	local point = Entities:FindByName( nil, "cellar_hero_home_spawner_1"):GetAbsOrigin()
	local activator = data.activator

	if caller == "trigger_teleport_from_cellar_1" then
		point = Entities:FindByName( nil, "cellar_hero_home_spawner_1"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_from_cellar_2" then
		point = Entities:FindByName( nil, "cellar_hero_home_spawner_2"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_from_cellar_3" then
		point = Entities:FindByName( nil, "cellar_hero_home_spawner_3"):GetAbsOrigin()
	end

	activator:SetAbsOrigin(point) 
	FindClearSpaceForUnit(activator, point, false) 
	activator:Stop()
	main:FocusCameraOnPlayer(activator)
end