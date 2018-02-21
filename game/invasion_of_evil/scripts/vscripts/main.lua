if main == nil then
    main = class({})
end

function main:InitGameMode()
   --print( "InitGameMode" )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

    GameRules:SetUseUniversalShopMode( true )
    GameRules:SetHeroSelectionTime( 30.0 )
    GameRules:SetStrategyTime( 0.0 )
    GameRules:SetShowcaseTime( 0.0 )
    GameRules:SetPreGameTime( 5.0 )

    GameRules:SetGoldTickTime( 60.0 )
    GameRules:SetGoldPerTick( 0 )
    GameRules:SetStartingGold( 0 )    

    GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
    GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
    GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )
    GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )

    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_rubick');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_dragon_knight');

    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(main, "DamageFilter"), self) 

    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self) 
    ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)   
    ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(main, "OnEntityKilled"), self)
    ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(main, 'OnItemPickedUp'), self) 
    ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(main, 'OnAbilityLearned'), self) 
    ListenToGameEvent( "player_chat", Dynamic_Wrap( main, "OnChat" ), self )


    PORTAL_OW_POINT = Entities:FindByName( nil, "trigger_teleport"):GetAbsOrigin()
    SPAWNER_OW_POINT = Entities:FindByName( nil, "otherkin_world_spawner"):GetAbsOrigin()

   --AddFOWViewer(DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, 2000, 60, false)
    --self:TestBosses()
    self:SpanwMoobs()
end


function main:SetPortalOwExist(flag)
    PORTAL_OW_EXIST = flag
end

function main:SetWaveState(flag)
    WAVE_STATE = flag
end

function main:ApplyMusicOn(soundName,hSource)
    --print("SetMusicSource")
    MUSIC_SOURCE = hSource
    StartSoundEvent(soundName,hSource)
end

function main:GameRulesStateChange(data)
    local newState = GameRules:State_Get()
    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameRules:SendCustomMessageToTeam("#start_necromancer_message_1", DOTA_TEAM_GOODGUYS, 0, 0)
        GameRules:SendCustomMessageToTeam("#start_necromancer_message_2", DOTA_TEAM_GOODGUYS, 0, 0)
        EmitGlobalSound("Invasion_of_evil.Nocturnus")
        
        --GameRules:SendCustomMessage("<font color='#58ACFA'>Luka - Shadow House(skyrim mods)</font>", 0, 0)
        GameRules:SendCustomMessage("<font color='#58ACFA'>Adrian von Ziegler - Nocturnus</font>", 0, 0)
    end
end


function main:OnNPCSpawn(data)
    --print("OnNPCSpawn")
    local unit = EntIndexToHScript(data.entindex)

    if unit:IsRealHero() then
        
        Timers:CreateTimer(1, function()
            unit:RemoveModifierByName("modifier_silencer_int_steal")
          return nil
        end
        )

        if not unit.next_spawn then

            unit.next_spawn = true; 
            unit:SetAbilityPoints(0)
            unit:SetGold(5, true)

            local ability = nil 
            for i = 0, 3 do
                ability = unit:GetAbilityByIndex(i)
                if ability then
                    ability:SetLevel(1)
                end 
            end
     
            if unit:HasAnyAvailableInventorySpace() then
                --unit:AddItemByName("item_entrails_evil")
                --unit:AddItemByName("item_heart")
            end
        end
    end

end


function main:OnAbilityLearned(data)
    --print("OnAbilityLearned")
    local hHero = PlayerResource:GetPlayer(data.PlayerID):GetAssignedHero()
    local ability = hHero:FindAbilityByName(data.abilityname)
    local pathName = nil
        
    if ability:GetLevel() <= 1 then
        if not data.abilityname:find("special_bonus") then
            if data.abilityname:find("berserk") then
                pathName = "berserk"
            end
            if data.abilityname:find("templar") then
                pathName = "templar"
            end  
            if data.abilityname:find("sapient") then
                pathName = "sapient"
            end              

            hHero:RemoveAbility(data.abilityname)

            for i = 0, 3 do
                local fallAbility = hHero:GetAbilityByIndex(i)
                if fallAbility then
                    if fallAbility:GetLevel() <= 0 then
                        hHero:RemoveAbility(fallAbility:GetAbilityName())
                    end
                end
            end

           ability = hHero:AddAbility(data.abilityname)
           ability:SetLevel(1)
           
           AddPathAbilitiesToHero({
                caster = hHero, 
                Path = pathName, 
                Tier = ability:GetAbilityIndex()+2
            })
       end
   end
end

function main:OnPlayerGainedLevel(data)

end


function main:OnSomeHeroKilled(data)

end

function main:OnEntityKilled(data)
    
    local killedEntity = EntIndexToHScript(data.entindex_killed)

    if killedEntity:IsCreature()  then

        if killedEntity:GetUnitName() == "npc_necromant_base" then
            GameRules:SendCustomMessageToTeam("#necromancer_die", DOTA_TEAM_GOODGUYS, 0, 0)
            GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
        end

        if killedEntity:GetTeamNumber() == DOTA_TEAM_NEUTRALS then


            if killedEntity:GetUnitName() == "final_boss" then
                GameRules:SendCustomMessageToTeam("#final_boss_die", DOTA_TEAM_GOODGUYS, 0, 0)
                GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
            end

            if RollPercentage(HEAL_DROP_PERC) then
                self:CreateDrop("item_potion_of_heal", killedEntity:GetAbsOrigin())
            end

            if not killedEntity:GetUnitName():find("wave") then
                if RollPercentage(SKULL_DROP_PERC) then
                    self:CreateDrop("item_skull_of_evil", killedEntity:GetAbsOrigin())
                end

                if RollPercentage(COMMON_DROP_PERC) then
                    if killedEntity:GetUnitName():find("start") then
                        self:CreateDrop(GetRandomItemNameFrom("start"), killedEntity:GetAbsOrigin())
                    else
                        self:CreateDrop(GetRandomItemNameFrom("common"), killedEntity:GetAbsOrigin())
                    end
                end
            end

            if killedEntity:GetUnitName():find("mini_boss") then
                self:RespawnMiniBoss(killedEntity:GetUnitName(), killedEntity.modelName, killedEntity.modelScale, killedEntity.vSpawnLoc, MINI_BOSS_RESPAWN_TIME)
                if RollPercentage(100) then
                    self:CreateDrop(GetRandomItemNameFrom("common"), killedEntity:GetAbsOrigin())
                end
                if RollPercentage(ENTRAILS_EVIL_DROP_PERC) then
                    self:CreateDrop("item_entrails_evil", killedEntity:GetAbsOrigin())
                end 
                if RollPercentage(1) then
                    self:CreateDrop(GetRandomItemNameFrom("unique"), killedEntity:GetAbsOrigin())
                end        
            end  

            if killedEntity:GetUnitName():find("big_boss") then
                if RollPercentage(100) then
                    self:CreateDrop("item_heart_of_evil", killedEntity:GetAbsOrigin())
                end 
                if RollPercentage(100) then
                    self:CreateDrop(GetRandomItemNameFrom("unique"), killedEntity:GetAbsOrigin())
                end 
                GameRules:SendCustomMessageToTeam("#teleport_back", DOTA_TEAM_GOODGUYS, 0, 0)
                Timers:CreateTimer(15, function()
                    self:ApplyBackTeleport() 
                    return nil
                end
                )                
                      
            end

            if killedEntity.spawner then
                if killedEntity:GetUnitName():find("start") then
                    self:RespawnStartUnits(killedEntity:GetUnitName(),killedEntity.vSpawnLoc,MINIONS_COUNT,START_MONS_RESPAWN_TIME)
                else 
                    self:RespawnUnits(killedEntity:GetUnitName(), killedEntity.modelName, killedEntity.modelScale, killedEntity.vSpawnLoc,MINIONS_COUNT,MONSTERS_RESPAWN_TIME)
                end
            end

        end
    end 

    if killedEntity:IsRealHero()  then
        main:GiveNewHero(killedEntity)
    end    
end

function main:SpanwMoobs()

    local point = nil
    local unit = nil

    point = Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin()
    unit = CreateUnitByName("npc_necromant_base", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(0,-1,0))
    --self:ApplyMusicOn("Invasion_of_evil.ShadowHouse",unit)

    point = Entities:FindByName( nil, "npc_spawner_2" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(-1,-1,0))

    point = Entities:FindByName( nil, "npc_spawner_3" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(1,-1,0))

    point = Entities:FindByName( nil, "npc_spawner_4" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(0,1,0))

    for i = 1, 3 do
        point = Entities:FindByName( nil, "start_monster_spawner_" .. i ):GetAbsOrigin()
        self:RespawnStartUnits("npc_start_evil_warrior", point, MINIONS_COUNT, 1)
    end

    for i = 1, 5 do
        self:CreateUnits("cemetery", i, 1)
        self:CreateUnits("church", i, 1)
        self:CreateUnits("cursed_tree", i, 1)     
    end      
end


function main:CreateUnits(biomName,spawnerNumber,time)
    --print("CreateUnits")
    if biomName and spawnerNumber and time then
        local unitSettings = GetUnitFor(biomName, spawnerNumber) or nil
        local point = Entities:FindByName( nil, biomName .. "_spawner_" .. spawnerNumber ):GetAbsOrigin() or nil

        if unitSettings and point then
            if unitSettings[1] == "npc_mini_boss"  then
                self:RespawnMiniBoss(unitSettings[1], unitSettings[2], unitSettings[3], point, time)
            else
                self:RespawnUnits(unitSettings[1], unitSettings[2], unitSettings[3], point, MINIONS_COUNT, time)   
            end      
        end
    end
end



function main:RespawnStartUnits(unitName,SpawnLoc,numMinions,time)
    
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    
    Timers:CreateTimer(time, function()
        unit = CreateUnitByName(unitName, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 
        unit.spawner = true

        for i = 1, numMinions do 
            unit = CreateUnitByName(unitName, SpawnLoc + RandomVector(100), true, nil, nil, team )
        end

      return nil
    end
    )
end


function main:RespawnUnits(unitName,modelName,modelScale,SpawnLoc,numMinions,time)
    
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    
    Timers:CreateTimer(time, function()
        unit = CreateUnitByName(unitName, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 
        unit.modelName = modelName
        unit.spawner = true
        unit:SetOriginalModel(modelName)
        unit.modelScale = modelScale
        unit:SetModelScale(modelScale)

        local modifier = unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})

        for i = 1, numMinions do 
            unit = CreateUnitByName(unitName, SpawnLoc + RandomVector(100), true, nil, nil, team )
            unit:SetOriginalModel(modelName)
            unit:SetModelScale(modelScale)
            unit.spawner = false
            if modifier:CanBeAddToMinions() then
                unit:AddNewModifier(unit, nil, modifier:GetName(), {})
            end
        end

      return nil
    end
    )
end


function main:RespawnMiniBoss(unitName,modelName,modelScale,SpawnLoc,time)
    
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    local modifName = nil

    
    Timers:CreateTimer(time, function()
        unit = CreateUnitByName(unitName, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 
        unit.modelName = modelName
        unit:SetOriginalModel(modelName)
        unit.modelScale = modelScale
        unit:SetModelScale(modelScale)

        local modifCount = 0

        for i = 0, 10 do
            modifName = GetRandomModifierName()
            if not unit:HasModifier(modifName) then
                unit:AddNewModifier(unit, nil, modifName, {})
                modifCount = modifCount + 1
            end
            if modifCount >= 3 then
                break
            end
        end

      return nil
    end
    )
end


function main:GiveNewHero(oldHero)
    local playerID = oldHero:GetPlayerID()
    local newHero = nil
    local ability = nil
    local abilityCount = oldHero:GetAbilityCount()
    if playerID ~= nil and playerID ~= -1 then
        for i = 0, 11 do
            oldHero:RemoveItem(oldHero:GetItemInSlot(i))
        end
        for i = 0, abilityCount-1 do
            ability = oldHero:GetAbilityByIndex(i)
            if ability then
                oldHero:RemoveAbility(ability:GetAbilityName())
            end
        end
        newHero = PlayerResource:ReplaceHeroWith(playerID, oldHero:GetName(), 0, 0)
        UTIL_Remove(oldHero)
        newHero:RespawnHero(false, false)
    end
end


function main:CreateDrop(itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   local drop = CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 50)))

    Timers:CreateTimer(TIME_BEFORE_REMOVE_DROP, function()
        if newItem and IsValidEntity(newItem) then
            if not newItem:GetOwnerEntity() then 

                if drop and IsValidEntity(drop) then 
                    UTIL_Remove(drop) 
                end

                UTIL_Remove(newItem)
            end
        end
      return nil
    end
    )
end


function main:OnItemPickedUp(data)
    --print("spawn")
    local itemName = data.itemname
    local hero = PlayerResource:GetSelectedHeroEntity(data.PlayerID) 
    local item = EntIndexToHScript(data.ItemEntityIndex)
    local charges = 0

    if itemName == "item_skull_of_evil" then
        for i = 0, 9 do
            item = hero:GetItemInSlot(i)
            if item ~= nil then
                if item:GetAbilityName() == itemName then
                    charges = charges + item:GetCurrentCharges()
                    UTIL_Remove(item)               
                end
            end
        end 

        item = hero:AddItemByName(itemName)
        item:SetCurrentCharges(charges)
        item:SetPurchaseTime(0) 
    end
end


function main:DamageFilter(data)
    local damage                = data.damage
    local entindex_inflictor_const  = data.entindex_inflictor_const
    local entindex_victim_const     = data.entindex_victim_const
    local entindex_attacker_const   = data.entindex_attacker_const
    local damagetype_const      = data.damagetype_const
    local hAbility = nil
    local hVictim = nil
    local hAttacker = nil

    if damage > 0 then

        if (entindex_inflictor_const) then 
            hAbility = EntIndexToHScript(entindex_inflictor_const) 
        end
        if (entindex_victim_const) then 
            hVictim  = EntIndexToHScript(entindex_victim_const)
            if hVictim:IsRealHero() then
                data.damage = self:ManaShieldReduceDmg(hVictim,data.damage)
                data.damage = self:BerserkRageReduceDmg(hVictim,data.damage)
            end
        end

        if (entindex_attacker_const) and (entindex_victim_const) then 
            hAttacker    = EntIndexToHScript(entindex_attacker_const)
            hVictim  = EntIndexToHScript(entindex_victim_const)
            if hAttacker:IsRealHero() then
                if hAttacker:HasItemInInventory("item_amulet_of_conversion") then
                    self:ApplyItemLifestealToHero(hAttacker,data.damage,"item_amulet_of_conversion")
                end
            end 
        end
        
    end
    return true;
end


function main:ApplyItemLifestealToHero(hHero,damage,itemName)
    --print("ApplyItemLifestealToHero")
    local item = nil
    local heal = nil

    for i = 0, 5 do
        item = hHero:GetItemInSlot(i)
        if item then
            if item:GetAbilityName() == itemName then
                break
            end
        end
    end

    if item then
        heal = damage*item:GetSpecialValueFor("lifesteal_percent")/100
        hHero:Heal(heal, hHero)
        ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, hHero)
    end   
end

function main:ManaShieldReduceDmg(hHero,damage)
    local ability = hHero:FindAbilityByName("sapient_mana_shield") or nil
    if ability and ability:GetLevel() > 0 then
        local abs_persent = ability:GetSpecialValueFor("absorption_percent")/100
        if hHero:GetMana() >= damage*abs_persent then
            hHero:SpendMana(damage*abs_persent, ability)
            damage = damage*(1-abs_persent)
        end 
    end
    return damage   
end 

function main:BerserkRageReduceDmg(hHero,damage)
    local ability = hHero:FindAbilityByName("berserk_rage") or nil
    if ability and ability:GetLevel() > 0 and ability:IsCooldownReady() then
        local maxHealth = hHero:GetMaxHealth()
        local thresholdPerc = ability:GetSpecialValueFor("threshold_percent")/100
        local health = hHero:GetHealth() - damage
        if health < thresholdPerc*maxHealth then
            hHero:AddNewModifier(hHero, ability, "modifier_berserk_rage", {duration = ability:GetSpecialValueFor("duration")})
            ability:StartCooldown(ability:GetCooldown(1))
            damage = 0
        end
    end
    return damage 
end


function main:FocusCameraOnPlayer(player)
    PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
    Timers:CreateTimer(1, function()
        PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
        return nil
    end
    )
end


--playerid,text,teamonly,userid,splitscreenplayer
function main:OnChat( data )

    local player = PlayerResource:GetPlayer(data.playerid) 
    local text = data.text
    if text == "-stopsound" then
        --StopSoundEvent("Invasion_of_evil.ShadowHouse",MUSIC_SOURCE)
        --StopSoundEvent("Invasion_of_evil.EpicFight1",MUSIC_SOURCE)
    end
end

function main:ApplyBackTeleport()
    local units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, nil, 2000,
    DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
    
    if units then   
        for i = 1, #units do
            if units[i]:IsRealHero() then
                units[i]:RespawnHero(false, false)
                self:FocusCameraOnPlayer(units[i])
            else
                UTIL_Remove(units[i])
            end
        end
    end
end

function main:TestBosses()
    local unit = CreateUnitByName("cursed_flame_boss", SPAWNER_OW_POINT, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})

    --unit:SetAbsOrigin(Entities:FindByName( nil, "hero_teleport_spawner"):GetAbsOrigin())
end

