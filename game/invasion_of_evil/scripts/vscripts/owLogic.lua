function StartOwTimer()

    Timers:CreateTimer(60, function()
    	--print("--------------OW TIMER---------------")

		if PORTAL_OW_EXIST == true or WAVE_STATE == true  or FINAL_BOSS_STATE == true then
			--print("PORTAL_OW_EXIST or  WAVE_STATE")
			return 60
		end	

		local currentTime = math.floor(GameRules:GetDOTATime(false,false))
		local repeatTime =  currentTime - LAST_OW_PORTAL_TIME
		--print("curr time: " .. currentTime )
		--print("last time: " .. LAST_OW_PORTAL_TIME)
		--print("repeat time: " .. repeatTime)

		if repeatTime >= PORTAL_REPEAT_TIME then
			--print("CreateWaves")
			LAST_OW_PORTAL_TIME = currentTime
			CreateWaves()
			return 60
		end

		if repeatTime >= ATTENTION_REPEAT_TIME then
			--print("CreateWaves")
			GameRules:SendCustomMessageToTeam("#attention_time", DOTA_TEAM_GOODGUYS, 0, 0)
			EmitGlobalSound("Tutorial.Quest.complete_01")
		end

		return 60
    end
    )

end

function CreateWaves()
	local point = nil
	local targetPoint = Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin()
	local waveCount = WAVE_DURATION
	local unit = nil

	WAVE_STEP = 5 - PlayerResource:GetTeamPlayerCount()
	--print("player count:  " .. PlayerResource:GetTeamPlayerCount())

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

			waveCount = waveCount - WAVE_STEP
      		return WAVE_STEP
      	end

      	if waveCount == 0 then
      		waveCount = -1
      		GameRules:SendCustomMessageToTeam("#wave_end", DOTA_TEAM_GOODGUYS, 0, 0)
      		return BREAK_AFTER_WAVE
      	end

      	CreateNewPortal()
      	return nil
    end
    )
end


function CreateNewPortal()
	--print("CreateNewPortal")

	main:SetWaveState(false)
	main:SetPortalOwExist(true)
	CreatePortalAnimation()
	StartSoundEventFromPosition("Hero_ShadowDemon.Disruption",PORTAL_OW_POINT)
	SpawnNewOWBoss()
	PORTAL_OW_CURRENT_THINK_NUMBER = 1


    Timers:CreateTimer(30, function()

    	if PORTAL_OW_CURRENT_THINK_NUMBER >= PORTAL_OW_THINK_COUNT then
    		DestroyPortal()
    		return nil
    	end

    	if BOSS_OW_ELIVE then
    		PORTAL_OW_CURRENT_THINK_NUMBER = PORTAL_OW_CURRENT_THINK_NUMBER + 1
    		return 30
    	end

       	DestroyPortal()
      	return nil
    end
    )
end


function SpawnNewOWBoss()
    local unit = nil
    
    unit = CreateUnitByName(BOSSES_NAME[RandomInt(1, #BOSSES_NAME)], SPAWNER_OW_POINT, true, nil, nil, DOTA_TEAM_NEUTRALS )      
    unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})
    main:SetBossOwStatus(true)
    unit:CreatureLevelUp(MINIONS_LEVEL - 1)

    for i = 1, BOSS_MINIONS_COUNT do 
        unit = CreateUnitByName("npc_minion_ow", SPAWNER_OW_POINT + RandomVector(700), true, nil, nil, DOTA_TEAM_NEUTRALS )
        unit:CreatureLevelUp(MINIONS_LEVEL - 1)
        unit.spawner = true
    end

   --[[] Timers:CreateTimer(0, function()
    	if SPAWNER_OW_POINT and PORTAL_OW_EXIST and BOSS_OW_ELIVE then
		    for i = 1, BOSS_MINIONS_COUNT do 
		        unit = CreateUnitByName("npc_minion_ow", SPAWNER_OW_POINT + RandomVector(100), true, nil, nil, DOTA_TEAM_NEUTRALS )
		        unit:CreatureLevelUp(MINIONS_LEVEL - 1)
		    end
      		return 20
      	end
      	return nil
    end
    )--]]

end

function CreatePortalAnimation()
	--print("CreatePortalAnimation")
	Timers:CreateTimer(0, function()
		if PORTAL_OW_POINT and PORTAL_OW_EXIST then
	    	TP_PARTICLE_ID = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf", PATTACH_CUSTOMORIGIN, self)
	    	ParticleManager:SetParticleControl(TP_PARTICLE_ID, 0, PORTAL_OW_POINT )
	   		ParticleManager:SetParticleControl(TP_PARTICLE_ID, 1, Vector(300, 0, 0))
		end

		if PORTAL_OW_EXIST then
			return 10
		end

		return nil
	end
	)

end

function DestroyPortal()
	--print("DestroyPortal")
	GameRules:SendCustomMessageToTeam("#teleport_end", DOTA_TEAM_GOODGUYS, 0, 0)
	Timers:CreateTimer(15, function()
    	
		main:SetPortalOwExist(false)
		if TP_PARTICLE_ID then
			ParticleManager:DestroyParticle(TP_PARTICLE_ID, false)
			ParticleManager:ReleaseParticleIndex(TP_PARTICLE_ID)
			TP_PARTICLE_ID = nil
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

		--возможно понадобиться, если нужно будет точнее настраивать время
		MINIONS_LEVEL = MINIONS_LEVEL + 3
		--LAST_OW_PORTAL_TIME = math.floor(GameRules:GetDOTATime(false,false)) - 120
		GameRules:SendCustomMessageToTeam("#teleport_wait", DOTA_TEAM_GOODGUYS, 0, 0)

		if MINIONS_LEVEL <= 5 then
			GameRules:SendCustomMessage("#help_messages_11", 0, 0)
			AddFOWViewer(DOTA_TEAM_GOODGUYS, Entities:FindByName( nil, "cursed_tree_spawner_5"):GetAbsOrigin(), 300, 60, false)
    		AddFOWViewer(DOTA_TEAM_GOODGUYS, Entities:FindByName( nil, "cemetery_spawner_5"):GetAbsOrigin(), 300, 60, false)
    		AddFOWViewer(DOTA_TEAM_GOODGUYS, Entities:FindByName( nil, "church_spawner_5"):GetAbsOrigin(), 300, 60, false)
		end
		
		return nil
    end)
end