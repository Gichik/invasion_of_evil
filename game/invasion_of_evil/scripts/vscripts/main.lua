if main == nil then
    main = class({})
end


function main:InitGameMode()
    print( "InitGameMode" )
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

    PORTAL_OW_POINT = Entities:FindByName( nil, "trigger_teleport"):GetAbsOrigin()
    SPAWNER_OW_POINT = Entities:FindByName( nil, "otherkin_world_spawner"):GetAbsOrigin()

    AddFOWViewer(DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, 2000, 60, false)
end


function main:GameRulesStateChange(data)
    local newState = GameRules:State_Get()
    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        main:SpanwMoobs()
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
            --unit:SetGold(0,false)
            unit:SetAbilityPoints(0)

            local ability = nil 
            for i = 0, 3 do
                ability = unit:GetAbilityByIndex(i)
                if ability then
                    ability:SetLevel(1)
                end 
            end
     
            if unit:HasAnyAvailableInventorySpace() then
                unit:AddItemByName("item_chain_lightning_scepter")
                --unit:AddItemByName("item_chain_lightning_scepter_second")
                unit:AddItemByName("item_chain_lightning_scepter_third")
                unit:AddItemByName("item_entrails_evil")
                unit:AddItemByName("item_entrails_evil")
                unit:AddItemByName("item_entrails_evil")
                unit:AddItemByName("item_entrails_evil")
                unit:AddItemByName("item_entrails_evil")
                unit:AddItemByName("item_entrails_evil") 
                unit:AddItemByName("item_cleave_sword")               
                --unit:AddItemByName("item_cleave_sword_second")
                --unit:AddItemByName("item_cleave_sword_third")
               -- unit:AddItemByName("item_vortex_axe")
               -- unit:AddItemByName("item_vortex_axe_second")
                --unit:AddItemByName("item_vortex_axe_third")
                unit:AddItemByName("item_heart")
                unit:AddItemByName("item_bloodstone")
                --unit:AddNewModifier(unit, nil, "modifier_berserk_crit", {})

            end
        end
    end

end

function main:OnAbilityLearned(data)
    --print("OnAbilityLearned")

    --local hHero = PlayerResource:GetPlayer(data.PlayerID):GetAssignedHero()
    local hHero = PlayerResource:GetPlayer(data.player-1):GetAssignedHero()
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
                if fallAbility and fallAbility:GetLevel() <= 0 then
                    hHero:RemoveAbility(fallAbility:GetAbilityName())
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
        if killedEntity:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
            if RollPercentage(50) then
                main:CreateDrop("item_skull_of_evil", killedEntity:GetAbsOrigin())
            end

            if killedEntity:GetUnitName():find("_mini_boss") then
                self:RespawnMiniBoss(killedEntity:GetUnitName(), killedEntity.modelName, killedEntity.modelScale, killedEntity.vSpawnLoc, MINI_BOSS_RESPAWN_TIME)
            end  

            if killedEntity.spawner then
                if killedEntity:GetUnitName():find("_start") then
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
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))

    Timers:CreateTimer(5, function()
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
                data.damage = self:ManaShieldReduceDmg(hVictim,data.damage,modifier)
                data.damage = self:BerserkRageReduceDmg(hVictim,data.damage,modifier)
            end
        end

        if (entindex_attacker_const) and (entindex_victim_const) then 
            hAttacker    = EntIndexToHScript(entindex_attacker_const)
            hVictim  = EntIndexToHScript(entindex_victim_const)
        end
        
    end
    return true;
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


function main:SetPortalOwExist(flag)
    PORTAL_OW_EXIST = flag
end


function main:FocusCameraOnPlayer(player)
    PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
    Timers:CreateTimer(1, function()
        PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
        return nil
    end
    )
end