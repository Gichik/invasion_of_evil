require( 'constant_links' )
if item_entrails_evil == nil then
	item_entrails_evil = class({})
end


function item_entrails_evil:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return UF_FAIL_CUSTOM
		end		

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end		

		if PORTAL_OW_EXIST == true or WAVE_STATE == true then
			return UF_FAIL_CUSTOM
		end	

		return UF_SUCCESS
	end
end


function item_entrails_evil:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return "#dota_hud_error_bad_target"
		end	

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end	

		if PORTAL_OW_EXIST == true or WAVE_STATE == true then
			return "#dota_hud_error_necromant_tired"
		end	

		return UF_SUCCESS
	end
end

function item_entrails_evil:OnSpellStart()
	--print("OnSpellStart")
	if IsServer() then
		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self
		self.think_number = 1

		hTarget:EmitSound("Item.DropWorld")
		if hTarget:GetUnitName() == "npc_necromant_base" then

			if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
				hCaster:RemoveItem(hItem)
			else
				hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
			end

			if hTarget:HasModifier("modifier_teleport_progress") then
				local modifier = hTarget:FindModifierByName("modifier_teleport_progress")
				modifier:IncrementStackCount()

				if modifier:GetStackCount() >= ENTRAILS_FOR_PORTAL then
					hTarget:RemoveModifierByName("modifier_teleport_progress")
					self:CreateWawes()
				end
			else
				hTarget:AddNewModifier(hTarget, nil, "modifier_teleport_progress", {}):IncrementStackCount()
			end
			
		end
	end
end


function item_entrails_evil:CreateWawes()
	local point = nil
	local targetPoint = Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin()
	local waveCount = WAVE_DURATION
	local unit = nil

	GameRules:SendCustomMessageToTeam("#wave_start", DOTA_TEAM_GOODGUYS, 0, 0)
	EmitGlobalSound("Invasion_of_evil.EpicFight1")
	GameRules:SendCustomMessage("<font color='#58ACFA'>Music: Daniel Pemberton - (ost)King Arthur: Legend of the Sword</font>", 0, 0)
	
	main:SetWaveState(true)

    Timers:CreateTimer(1, function()
    	if waveCount > 0 and targetPoint then
			for i = 1, 6 do
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				if RollPercentage(50) then
			    	unit = CreateUnitByName("npc_melee_wave_warrior", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
			    	unit:CreatureLevelUp(MINIONS_LEVEL - 1)
				else
					unit = CreateUnitByName("npc_range_wave_warrior", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
					unit:CreatureLevelUp(MINIONS_LEVEL - 1)
				end
			end

			waveCount = waveCount - 2
      		return 2
      	end

      	if waveCount == 0 then
      		waveCount = -1
      		GameRules:SendCustomMessageToTeam("#wave_end", DOTA_TEAM_GOODGUYS, 0, 0)
      		return BREAK_AFTER_WAVE
      	end

      	self:CreateNewPortal()
      	return nil
    end
    )
end


function item_entrails_evil:CreateNewPortal()
	--print("CreateNewPortal")

	main:SetWaveState(false)
	main:SetPortalOwExist(true)
	self:CreatePortalAnimation()
	StartSoundEventFromPosition("Hero_ShadowDemon.Disruption",PORTAL_OW_POINT)
	self:SpawnNewOWBoss()
    Timers:CreateTimer(30, function()

    	if self.think_number >= PORTAL_OW_THINK_COUNT then
    		self:DestroyPortal()
    		return nil
    	end

    	if BOSS_OW_ELIVE then
    		self.think_number = self.think_number + 1
    		return 30
    	end

       	self:DestroyPortal()
      	return nil
    end
    )
end


function item_entrails_evil:CreatePortalAnimation()
	if IsServer() then
		--print("CreatePortalAnimation")
		Timers:CreateTimer(0, function()
			if PORTAL_OW_POINT and PORTAL_OW_EXIST then
		    	self.tpParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf", PATTACH_CUSTOMORIGIN, self)
		    	ParticleManager:SetParticleControl(self.tpParticleID, 0, PORTAL_OW_POINT )
		   		ParticleManager:SetParticleControl(self.tpParticleID, 1, Vector(300, 0, 0))
			end

			if PORTAL_OW_EXIST then
				return 10
			end

			return nil
		end
		)
	end
end

function item_entrails_evil:DestroyPortal()
	if IsServer() then
		--print("DestroyPortal")
		GameRules:SendCustomMessageToTeam("#teleport_end", DOTA_TEAM_GOODGUYS, 0, 0)
    	Timers:CreateTimer(15, function()
	    	
			main:SetPortalOwExist(false)
			if self.tpParticleID then
				ParticleManager:DestroyParticle(self.tpParticleID, false)
				ParticleManager:ReleaseParticleIndex(self.tpParticleID)
				self.tpParticleID = nil
			end

			local units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, nil, 2000,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
			
			if units then	
				for i = 1, #units do
					if units[i]:IsRealHero() then
						units[i]:RespawnHero(false, false)
						main:FocusCameraOnPlayer(units[i])
					else
						UTIL_Remove(units[i])
					end
				end
			end

			units = FindUnitsInRadius( DOTA_TEAM_NEUTRALS, SPAWNER_OW_POINT, nil, 2000,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
			
			if units then	
				for i = 1, #units do
					UTIL_Remove(units[i])
				end
			end

			return nil
	    end)

	end	
end



function item_entrails_evil:SpawnNewOWBoss()
    local unit = nil
    
    unit = CreateUnitByName(BOSSES_NAME[RandomInt(1, #BOSSES_NAME)], SPAWNER_OW_POINT, true, nil, nil, DOTA_TEAM_NEUTRALS )   
    unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})
    main:SetBossOwStatus(true)

    Timers:CreateTimer(0, function()
    	if SPAWNER_OW_POINT and PORTAL_OW_EXIST and BOSS_OW_ELIVE then
		    for i = 1, BOSS_MINIONS_COUNT do 
		        unit = CreateUnitByName("npc_minion_ow", SPAWNER_OW_POINT + RandomVector(100), true, nil, nil, DOTA_TEAM_NEUTRALS )
		        unit:CreatureLevelUp(MINIONS_LEVEL - 1)
		    end
      		return 20
      	end
      	return nil
    end
    )

end
