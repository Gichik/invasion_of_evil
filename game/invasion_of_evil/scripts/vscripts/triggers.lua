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

		if activator.controllableUnit then
			if not activator.controllableUnit:IsNull() then
				if activator.controllableUnit:IsAlive() then
					activator.controllableUnit:SetAbsOrigin(point) 
					FindClearSpaceForUnit(activator.controllableUnit, point, false) 
					activator.controllableUnit:Stop()
				end
			end
		end

	end
end


function TeleportHome(data)
	--print("TeleportTrigger")
	local activator = data.activator
    activator:RespawnHero(false, false)
    main:FocusCameraOnPlayer(activator)

	if activator.controllableUnit then
		if not activator.controllableUnit:IsNull() then
			if activator.controllableUnit:IsAlive() then
				activator.controllableUnit:SetAbsOrigin(activator:GetAbsOrigin()) 
				FindClearSpaceForUnit(activator.controllableUnit, activator:GetAbsOrigin(), false) 
				activator.controllableUnit:Stop()
			end
		end
	end

end

function TeleportTriggerDungJeepers(data)
	--print("TeleportTriggerDungJeepers")
	local activator = data.activator
	local modifier = activator:FindModifierByName("modifier_quest_dungeon_church") or nil
	local point = Entities:FindByName( nil, "dungeon_jeepers_hero_spawner"):GetAbsOrigin()

	if not modifier then
		return nil
	end

	if modifier:GetStackCount() >= CHARGES_FOR_CHURCH_DUNG  then
		activator:SetAbsOrigin(point) 
		FindClearSpaceForUnit(activator, activator:GetAbsOrigin(), false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
		modifier:SetStackCount(0)

		if activator.controllableUnit then
			if not activator.controllableUnit:IsNull() then
				if activator.controllableUnit:IsAlive() then
					activator.controllableUnit:SetAbsOrigin(point) 
					FindClearSpaceForUnit(activator.controllableUnit, point, false) 
					activator.controllableUnit:Stop()
				end
			end
		end

	end	

end


function TeleportTriggerDungCursed(data)
	--print("TeleportTriggerDungCursed")
	local activator = data.activator
	local modifier = activator:FindModifierByName("modifier_quest_dungeon_cursed") or nil
	local point = Entities:FindByName( nil, "dungeon_cursed_hero_spawner"):GetAbsOrigin()

	if not modifier then
		return nil
	end

	if modifier:GetStackCount() >= CHARGES_FOR_CURSED_DUNG  then
		activator:SetAbsOrigin(point) 
		FindClearSpaceForUnit(activator, activator:GetAbsOrigin(), false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
		modifier:SetStackCount(0)

		if activator.controllableUnit then
			if not activator.controllableUnit:IsNull() then
				if activator.controllableUnit:IsAlive() then
					activator.controllableUnit:SetAbsOrigin(point) 
					FindClearSpaceForUnit(activator.controllableUnit, point, false) 
					activator.controllableUnit:Stop()
				end
			end
		end

	end	
end


function TeleportTriggerDungCemetry(data)
	--print("TeleportTriggerDungCemetry")
	local activator = data.activator
	local modifier = activator:FindModifierByName("modifier_quest_dungeon_cemetry") or nil
	local point = Entities:FindByName( nil, "dungeon_cemetry_hero_spawner"):GetAbsOrigin()

	if not modifier then
		return nil
	end

	if modifier:GetStackCount() >= CHARGES_FOR_CEMETRY_DUNG  then
		activator:SetAbsOrigin(point) 
		FindClearSpaceForUnit(activator, activator:GetAbsOrigin(), false) 
		activator:Stop()
		main:FocusCameraOnPlayer(activator)
		modifier:SetStackCount(0)

		if activator.controllableUnit then
			if not activator.controllableUnit:IsNull() then
				if activator.controllableUnit:IsAlive() then
					activator.controllableUnit:SetAbsOrigin(point) 
					FindClearSpaceForUnit(activator.controllableUnit, point, false) 
					activator.controllableUnit:Stop()
				end
			end
		end

	end	

end

function TeleportTriggerCellar(data)
	--print("TeleportTrigger")
	if  not FINAL_BOSS_STATE then
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

		if activator.controllableUnit then
			if not activator.controllableUnit:IsNull() then
				if activator.controllableUnit:IsAlive() then
					activator.controllableUnit:SetAbsOrigin(point) 
					FindClearSpaceForUnit(activator.controllableUnit, point, false) 
					activator.controllableUnit:Stop()
				end
			end
		end
	end

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

	if activator.controllableUnit then
		if not activator.controllableUnit:IsNull() then
			if activator.controllableUnit:IsAlive() then
				activator.controllableUnit:SetAbsOrigin(point) 
				FindClearSpaceForUnit(activator.controllableUnit, point, false) 
				activator.controllableUnit:Stop()
			end
		end
	end

end

function BulletinBoardOpen(data)
	--print("BulletinBoardOpen")
	if IsServer() then
		local activator = data.activator
		local messageID = ""
		if not activator.board then
			activator.board = 0
		end

		activator.board = activator.board + 1
		if activator.board > 7 then
			activator.board = 1
		end

		if activator.board == 1 then
			messageID = "#1_bulletin_board_thanks_Description"
		end
		if activator.board == 2 then
			messageID = "#2_bulletin_board_thanks_Description"
		end
		if activator.board == 3 then
			messageID = "#3_bulletin_board_thanks_Description"
		end
		if activator.board == 4 then
			messageID = "#4_bulletin_board_thanks_Description"
		end
		if activator.board == 5 then
			messageID = "#5_bulletin_board_thanks_Description"
		end		
		if activator.board == 6 then
			messageID = "#6_bulletin_board_thanks_Description"
		end
		if activator.board == 7 then
			messageID = "#7_bulletin_board_thanks_Description"
		end	
			
		data.activator:EmitSound("Item.TomeOfKnowledge")
		CustomGameEventManager:Send_ServerToPlayer(data.activator:GetPlayerOwner(),"QuestMsgPanel_create_new_message", {messageName = "#bulletin_board", messageText = messageID})			
	end
end




function EventColossusBuild(data)

	if IsServer() then
		local activator = data.activator
		if activator:HasModifier("modifier_events_colossus_part") then
			activator.colossus_part_build = true;
			activator:RemoveModifierByName("modifier_events_colossus_part")
		end
	end

end


function EventCircleStartTouch(data)

	if IsServer() then
		local activator = data.activator
		if activator:IsRealHero() then
			--print("TOUCHING")
			main_chap_two:IncrementEventCirclePlayer()
		end
	end

end

function EventCircleEndTouch(data)

	if IsServer() then
		local activator = data.activator
		if activator:IsRealHero() then
			--print("END TOUCHING")
			main_chap_two:DecrementEventCirclePlayer()
		end
	end

end
