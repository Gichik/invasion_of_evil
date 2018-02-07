--outputid
--caller
--activator


function TeleportTrigger(data)
	print("TeleportTrigger")
	print(PORTAL_OW_EXIST)
	if PORTAL_OW_EXIST == true then

		print("teleport")
		local point = Entities:FindByName( nil, "spawner_3"):GetAbsOrigin()
		local activator = data.activator

		activator:SetAbsOrigin(point) 
		FindClearSpaceForUnit(activator, point, false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
	end
end