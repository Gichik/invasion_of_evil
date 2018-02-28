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