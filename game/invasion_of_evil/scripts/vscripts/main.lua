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

    GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
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
end


function main:GameRulesStateChange(data)
    local newState = GameRules:State_Get()
    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        main:SpanwMoobs()
    end
end


function main:OnNPCSpawn(data)

    local unit = EntIndexToHScript(data.entindex)

    if unit:IsHero() then
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
                --unit:AddItemByName("item_chain_lightning_scepter")
                --unit:AddItemByName("item_chain_lightning_scepter_second")
                unit:AddItemByName("item_chain_lightning_scepter_third")
                unit:AddItemByName("item_cleave_sword")
                unit:AddItemByName("item_cleave_sword_second")
                --unit:AddItemByName("item_cleave_sword_third")
                unit:AddItemByName("item_vortex_axe")
                --unit:AddItemByName("item_vortex_axe_second")
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
        if RollPercentage(50) then
            main:CreateDrop("item_skull_of_evil", killedEntity:GetAbsOrigin())
        end

        if killedEntity:HasAbility("respawn_settings") then
            main:RespawnUnits(killedEntity:GetUnitName(),killedEntity.vSpawnLoc,5,5)
        end
    end 

    if killedEntity:IsRealHero()  then
        main:GiveNewHero(killedEntity)
    end    
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

function main:SpanwMoobs()

    local point = Entities:FindByName( nil, "spawner_1"):GetAbsOrigin()
    --for i = 1, 5 do
    main:RespawnUnits("npc_zombie_spawner",point,5,1)
    --print("create")
    --print(unit.vSpawnLoc)
    --end

end

 
function main:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
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

function main:RespawnUnits(unitName,SpawnLoc,numMinions,time)
    
    local team = DOTA_TEAM_NEUTRALS

    local minionsName = string.gsub(unitName,"_spawner", "");

    Timers:CreateTimer(time, function()
        unit = CreateUnitByName(unitName, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 

        local modifier = unit:AddNewModifier(unit, nil, "modifier_explosive", {})

        for i = 1, numMinions do 
            unit = CreateUnitByName(minionsName, SpawnLoc, true, nil, nil, team )
            if modifier:CanBeAddToMinions() then
                unit:AddNewModifier(unit, nil, modifier:GetName(), {})
            end
        end

      return nil
    end
    )
end

function main:DamageFilter(data)
    local damage                = data.damage
    local entindex_inflictor_const  = data.entindex_inflictor_const
    local entindex_victim_const     = data.entindex_victim_const
    local entindex_attacker_const   = data.entindex_attacker_const
    local damagetype_const      = data.damagetype_const
    local ability = nil
    local victim = nil
    local attacker = nil


    if damage > 0 then

        if (entindex_inflictor_const) then 
            ability = EntIndexToHScript(entindex_inflictor_const) 
        end
        if (entindex_victim_const) then 
            victim  = EntIndexToHScript(entindex_victim_const)
            if victim:IsRealHero() then
                data.damage = self:ManaShieldReduceDmg(victim,data.damage,modifier)
                data.damage = self:BerserkRageReduceDmg(victim,data.damage,modifier)
            end
        end
        if (entindex_attacker_const) then 
            attacker    = EntIndexToHScript(entindex_attacker_const) 

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
            hHero:AddNewModifier(hHero, ability, "modifier_berserk_rage", {duration = 5})
            ability:StartCooldown(ability:GetCooldown(1))
            damage = 0
        end
    end
    return damage 
end