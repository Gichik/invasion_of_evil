if main_chap_two == nil then
    main_chap_two = class({})
end

--npc_spawner_bush_1
--npc_spawner_alchemist_1
--CustomGameEventManager

--cemetry_dungeon_spawner_1
--trigger_dung_cemetry_teleport_home
--trigger_teleport_dung_cemetry
--TeleportTriggerDungCemetry
--dungeon_cemetry_hero_spawner

--trigger_bulletin_board
--BulletinBoardOpen



function main_chap_two:InitGameMode()
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
    GameRules:SetHeroRespawnEnabled( false )
    GameRules:GetGameModeEntity():SetFixedRespawnTime(10)
    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)

    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(25)        
    GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )

    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_rubick');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_dragon_knight');

    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(main_chap_two, "DamageFilter"), self) 

    --CustomGameEventManager:RegisterListener( "event_scorebar_prepare", Dynamic_Wrap( main, "OnPrepareNewEvent" ))


    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main_chap_two, 'GameRulesStateChange'), self)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(main_chap_two, 'OnNPCSpawn'), self) 
    --ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main_chap_two, 'OnPlayerGainedLevel'), self)   
    ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main_chap_two, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(main_chap_two, "OnEntityKilled"), self)
    ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(main_chap_two, 'OnItemPickedUp'), self) 
 
    AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(-200,-150,0), 7000, -1, false)
    AddFOWViewer(DOTA_TEAM_BADGUYS, Vector(-200,-150,0), 7000, -1, false)

    PlAYER_COUNT = PlayerResource:GetTeamPlayerCount()
    --NUMBER_OF_WAVE = 12
end


function main_chap_two:SetEventReward(flag)
    EmitGlobalSound("Hero_LegionCommander.Duel.Victory")
    EVENT_REWARD = flag
end

function main_chap_two:EventCircleChangeActive(number, active)
    EVENT_CIRCLE_ACTIVE[number] = EVENT_CIRCLE_ACTIVE[number] + active
end

function main_chap_two:SetEventBloodCoinCount(flag)
    EVENT_BLOOD_COIN_COUNT = flag
end

function main_chap_two:SetEventColossusPartCount(flag)
    EVENT_COLLOSUS_PART_COUNT = flag
end

function main_chap_two:GameRulesStateChange(data)
    local newState = GameRules:State_Get()

    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        CustomGameEventManager:Send_ServerToAllClients("QuestAllMsgPanel_close",  {})

        Timers:CreateTimer(1, function()
            GameRules:SetTimeOfDay( 0.75 )
          return 60
        end
        ) 
        self:SendStartEventMassegae()
        self:CreateWave(15, "npc_wave_demon", "npc_wave_demon", "npc_wave_mini_boss", 50)       
    end
end


function main_chap_two:OnNPCSpawn(data)
    --print("OnNPCSpawn")
    PlAYER_COUNT = PlayerResource:GetTeamPlayerCount()

    local unit = EntIndexToHScript(data.entindex)

    if unit:IsRealHero() then

        Timers:CreateTimer(0.5, function()
            unit:RemoveModifierByName("modifier_silencer_int_steal")

            --удаляем вещи у рандом пик
            for i = 0, 8 do
                item = unit:GetItemInSlot(i)
                if item ~= nil then
                    --print(item:GetAbilityName())
                    if item:GetAbilityName():find("mango") or item:GetAbilityName():find("fire") then
                        unit:RemoveItem(item)
                    end
                end
            end

          return nil
        end
        )

        if not unit.next_spawn then
            
            unit.next_spawn = true; 
            unit:SetAbilityPoints(0)
            unit:SetGold(5, true)

            CreateRandomizeAbility(unit)
     
            if unit:HasAnyAvailableInventorySpace() then
                --unit:AddItemByName("item_ice_shards_spear")
                --unit:AddItemByName("item_blink")
                --unit:AddItemByName("item_heart")
                --unit:AddItemByName("item_radiance")
                --unit:AddItemByName("item_note_alchemist_one")
                --unit:AddItemByName("item_heart_of_evil")
                --unit:AddItemByName("item_heart_of_evil")
                --unit:AddItemByName("item_heart_of_evil")
                --unit:AddItemByName("item_skull_of_evil")
                --unit:AddItemByName("item_skull_of_evil")
                --unit:AddItemByName("item_skull_of_evil")
                --unit:AddItemByName("item_skull_of_evil")
                --unit:AddItemByName("item_skull_of_evil")
                --unit:AddNewModifier(unit, nil, "modifier_quest_dungeon_cemetry", {})
                --unit:AddNewModifier(unit, nil, "modifier_quest_dungeon_church", {})
                --unit:AddItemByName("item_enchantment_aura_hp_regen")
                --unit:AddItemByName("item_enchantment_taunt") 
            end

        end
    end

end


--player, level,splitscreenplayer
function main_chap_two:OnPlayerGainedLevel(data)
    --print("gained")
    local hPlayer = EntIndexToHScript(data.player)
    local hHero = hPlayer:GetAssignedHero()
    --[[if hHero:GetLevel() > 20 and hHero:GetLevel() < 25 then 
        hHero:SetAbilityPoints(hHero:GetAbilityPoints() + 1)
    end]]
end


function main_chap_two:OnSomeHeroKilled(data)

end


----entindex_attacker,entindex_killed,damagebits,splitscreenplayer

function main_chap_two:OnEntityKilled(data)
    
    local killedEntity = EntIndexToHScript(data.entindex_killed)
    local attackerEntity = EntIndexToHScript(data.entindex_attacker)

    if killedEntity:IsCreature()  then

        if killedEntity:GetTeamNumber() == DOTA_TEAM_BADGUYS then
            if CURRENT_MONSTER_COUNT > 0 then

                if killedEntity:GetUnitName() ~= "npc_altar" and killedEntity:GetUnitName() ~= "duplicate_cursed_flame" then      
                    CURRENT_MONSTER_COUNT = CURRENT_MONSTER_COUNT - 1
                end

                --print("Event reward: " .. EVENT_REWARD)
                if EVENT_NUMBER == 1 and EVENT_REWARD == 0 then
                    if RollPercentage(50) then
                        self:CreateDrop("item_blood_coin", killedEntity:GetAbsOrigin())
                    end
                end

            end


            if RollPercentage(HEAL_DROP_PERC) then
                self:CreateDrop("item_potion_of_heal", killedEntity:GetAbsOrigin())
            end

            if RollPercentage(HEAL_DROP_PERC) then
                self:CreateDrop("item_potion_of_mana", killedEntity:GetAbsOrigin())
            end 

            --print(killedEntity:GetDeathXP())
            if attackerEntity:IsRealHero() then
                local bonusXP = killedEntity:GetDeathXP()*(PlAYER_COUNT-1)/PlAYER_COUNT
                attackerEntity:AddExperience(bonusXP, 0, true, true)
            end

            if killedEntity:GetUnitName():find("big_boss") then
                self:CreateDrop("item_heart_of_evil", killedEntity:GetAbsOrigin())                    
            end

        end
    end


    if killedEntity:IsRealHero() then


            local haveProtect = false
            for i = 0, 8 do
                item = killedEntity:GetItemInSlot(i)
                if item ~= nil then
                    if item:GetAbilityName() == "item_protective_amulet" then
                        haveProtect = true
                        killedEntity:RemoveItem(item)
                        break
                    end
                end
            end

            if haveProtect == true then
                killedEntity:RespawnHero(false, false)
                return nil
            end  

            local newItem = CreateItem( "item_tombstone", killedEntity, killedEntity )
            newItem:SetPurchaseTime( 0 )
            newItem:SetPurchaser( killedEntity )
            local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
            tombstone:SetContainedItem( newItem )
            tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
            FindClearSpaceForUnit( tombstone, killedEntity:GetAbsOrigin(), true )

            local AllDead = true
            local playerCount = PlayerResource:GetTeamPlayerCount()

            for i = 0, PlAYER_COUNT  do
                if PlayerResource:IsValidPlayer(i) then
                    if PlayerResource:GetSelectedHeroEntity(i):IsAlive() then
                        AllDead = false
                    end
                end
            end

            if AllDead then
                GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
            end


    end 
end


function main_chap_two:CreateDrop(itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   local drop = CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 50)))
   local timeBeforeRemove = TIME_BEFORE_REMOVE_DROP

    if itemName == "item_colossus_part" then
        timeBeforeRemove = WAVE_DURATION
    end

    Timers:CreateTimer(timeBeforeRemove, function()
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


function main_chap_two:OnItemPickedUp(data)
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


function main_chap_two:DamageFilter(data)
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
                data.damage = self:MagicShieldReduceDmg(hVictim,data.damage)
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


function main_chap_two:ApplyItemLifestealToHero(hHero,damage,itemName)
    --print("ApplyItemLifestealToHero")
    local item = nil
    local heal = nil
    local applyHeal = false

    for i = 0, 5 do
        item = hHero:GetItemInSlot(i)
        if item then
            if item:GetAbilityName() == itemName then
                applyHeal = true;
                break
            end
        end
    end

    if applyHeal then
        heal = damage*item:GetSpecialValueFor("lifesteal_percent")/100
        hHero:Heal(heal, hHero)
        ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, hHero)
    else
        return nil
    end   
end

function main_chap_two:ManaShieldReduceDmg(hHero,damage)
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

function main_chap_two:MagicShieldReduceDmg(hHero,damage)
    if hHero:HasModifier("modifier_elementalist_magic_shield_buff") then
        damage = 0
    end
    return damage   
end 


function main_chap_two:BerserkRageReduceDmg(hHero,damage)
    local ability = hHero:FindAbilityByName("berserk_rage") or nil
    if ability and ability:GetLevel() > 0 and ability:IsCooldownReady() then
        local maxHealth = hHero:GetMaxHealth()
        local thresholdPerc = ability:GetSpecialValueFor("threshold_percent")/100
        local health = hHero:GetHealth() - damage
        if health < thresholdPerc*maxHealth then
            hHero:AddNewModifier(hHero, ability, "modifier_berserk_rage", {duration = ability:GetSpecialValueFor("duration")})
            ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
            damage = 0
        end
    end
    return damage 
end


function main_chap_two:FocusCameraOnPlayer(player)
    PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
    Timers:CreateTimer(1, function()
        PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
        return nil
    end
    )
end



function main_chap_two:CreateWave(spawnInterval, waveMonstersType1, waveMonstersType2, bossName, rollPercType1)
    local point = nil
    local waveCount = WAVE_DURATION/spawnInterval
    local unit = nil
    local bossWaveCount = waveCount
    local modifName = nil
    local modifCount = 0
    local modifLimit = NUMBER_OF_WAVE - 1

    if NUMBER_OF_WAVE > 4 then
       modifLimit = 3
    end

    PlAYER_COUNT = PlayerResource:GetTeamPlayerCount()
    --WAVE_STEP = 7 - PlayerResource:GetTeamPlayerCount()

    if bossName == "npc_wave_mini_boss" then
        bossWaveCount = 1
    end

    self:StartNewEvent()
    EmitGlobalSound("Tutorial.Quest.complete_01")

    --print(NUMBER_OF_WAVE)
    --print(MODIFIER_WAVES_TABLE[NUMBER_OF_WAVE])

    Timers:CreateTimer(1, function()

        --босс
        if waveCount == bossWaveCount then
            point = Entities:FindByName( nil, "spawner_" .. RandomInt(1,40) ):GetAbsOrigin()
            unit = CreateUnitByName(bossName, point, true, nil, nil, DOTA_TEAM_BADGUYS )
            unit:CreatureLevelUp(NUMBER_OF_WAVE - 1)
            if bossName == "npc_wave_mini_boss" then
                for i = 0, 10 do
                    if modifCount >= modifLimit then
                        break
                    end                    
                    modifName = GetRandomModifierName()
                    if not unit:HasModifier(modifName) then
                        unit:AddNewModifier(unit, nil, modifName, {})
                        modifCount = modifCount + 1
                    end
                end
            else
                unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})
            end
            CURRENT_MONSTER_COUNT = CURRENT_MONSTER_COUNT + 1

            if NUMBER_OF_WAVE >= 13 then
                point = Entities:FindByName( nil, "spawner_" .. RandomInt(1,40) ):GetAbsOrigin()
                unit = CreateUnitByName("lump_of_flame_big_boss", point, true, nil, nil, DOTA_TEAM_BADGUYS )
                unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})
                unit:CreatureLevelUp(NUMBER_OF_WAVE - 1)

                point = Entities:FindByName( nil, "spawner_" .. RandomInt(1,40) ):GetAbsOrigin()
                unit = CreateUnitByName("flamethrower_big_boss", point, true, nil, nil, DOTA_TEAM_BADGUYS )
                unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})
                unit:CreatureLevelUp(NUMBER_OF_WAVE - 1)

                CURRENT_MONSTER_COUNT = CURRENT_MONSTER_COUNT + 2
            end


            --CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#necromancer_message_name", messageText = "#start_necromancer_message_1"})
            --if ACTIVE_MUSIC then
            --    EmitGlobalSound("Invasion_of_evil.AdrianVonZiegler_DeathDance")
            --    GameRules:SendCustomMessage("<font color='#58ACFA'>Music: Adrian Von Ziegler - Death Dance</font>", 0, 0)
            --end
        end

        --волна
        if waveCount > 0 then
                waveCount = waveCount - 1
                for i = 1, 40 do
                    if CURRENT_MONSTER_COUNT < 200 then
                        point = Entities:FindByName( nil, "spawner_" .. i):GetAbsOrigin()
                        if RollPercentage(rollPercType1) then
                            unit = CreateUnitByName(waveMonstersType1, point, true, nil, nil, DOTA_TEAM_BADGUYS )
                            unit:CreatureLevelUp(NUMBER_OF_WAVE - 1)
                        else
                            unit = CreateUnitByName(waveMonstersType2, point, true, nil, nil, DOTA_TEAM_BADGUYS )
                            unit:CreatureLevelUp(NUMBER_OF_WAVE - 1)
                        end

                        if NUMBER_OF_WAVE >= 4 and bossName == "npc_wave_mini_boss" then
                            unit:AddNewModifier(unit, nil, MODIFIER_WAVES_TABLE[NUMBER_OF_WAVE], {}) 
                        end

                        CURRENT_MONSTER_COUNT = CURRENT_MONSTER_COUNT + 1
                    end
                end
            return spawnInterval
        end

        --награда
        Timers:CreateTimer(10, function()
            --print("------------------WAVE END-----------------")
            --print(CURRENT_MONSTER_COUNT)
            if CURRENT_MONSTER_COUNT <= 0 then
                --print("------------------START NEW-----------------")
                CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_close",  {})  
                self:CreateWaveReward()
                self:PrepareToNewWave()
                return nil
            end
            return 5
        end
        )

        return nil  
    end
    )
end

function main_chap_two:CreateWaveReward()
    --print("------------------CreateWaveReward-----------------")
    local rareType1 = "first"
    local rareType2 = "second"

    if NUMBER_OF_WAVE == 1 then
        rareType2 = "first"
    end

    if NUMBER_OF_WAVE > 4 then
        rareType1 = "second"
        rareType2 = "third"
    end

    if NUMBER_OF_WAVE > 7 then
        rareType1 = "third"
        rareType2 = "third"
    end

    for i = 1, PlAYER_COUNT do
        if i <= 3 then
            local spawnPoint = Entities:FindByName( nil, "loot_spawner_" .. i):GetAbsOrigin()
            for i = 1, 15 do
                self:CreateDrop("item_skull_of_evil", spawnPoint)
            end  

            for i = 1, 3 do
                self:CreateDrop(GetRandomItemNameFrom(rareType1), spawnPoint)
            end

            self:CreateDrop(GetRandomItemNameFrom(rareType2), spawnPoint)
  
            if NUMBER_OF_WAVE == 4 or NUMBER_OF_WAVE == 7 or NUMBER_OF_WAVE >= 10 then
                self:CreateDrop(GetRandomItemNameFrom("unique"), spawnPoint)
                StartSoundEventFromPosition("DOTA_Item.Refresher.Activate",spawnPoint)
            end
        end
    end

end

function main_chap_two:SendStartEventMassegae()
    if NUMBER_OF_WAVE == 1 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_1"})
    end
    if NUMBER_OF_WAVE == 2 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_2"})
    end
    if NUMBER_OF_WAVE == 3 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_3"})
    end
    if NUMBER_OF_WAVE == 4 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_4"})
    end
    if NUMBER_OF_WAVE == 5 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_5"})
    end
    if NUMBER_OF_WAVE == 6 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_6"})
    end
    if NUMBER_OF_WAVE == 7 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_7"})
    end
    if NUMBER_OF_WAVE == 8 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_8"})
    end
    if NUMBER_OF_WAVE == 9 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_9"})
    end
    if NUMBER_OF_WAVE == 10 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_10"})
    end
    if NUMBER_OF_WAVE == 11 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_11"})
    end
    if NUMBER_OF_WAVE == 12 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_12"})
    end
    if NUMBER_OF_WAVE == 13 then
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_wave_head", messageText = "#start_wave_13"})
    end
end

function main_chap_two:PrepareToNewWave()
    --print("------------------PrepareToNewWave-----------------")

    
    NUMBER_OF_WAVE = NUMBER_OF_WAVE + 1

    if NUMBER_OF_WAVE > 13 then
        GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
        return nil
    end

    self:SendStartEventMassegae()

    local bossName = "npc_wave_mini_boss"
    local monsterType1 = "npc_melee_wave_warrior_ch2"
    local monsterType2 = "npc_range_wave_warrior_ch2"
    local interval = math.floor(15/PlAYER_COUNT)
    local rollPercType1 = 50

    if NUMBER_OF_WAVE == 2 then
        monsterType1 = "npc_wave_zombie"
        monsterType2 = "npc_wave_ghost"
        rollPercType1 = 80
    end

    if NUMBER_OF_WAVE == 4 then
        bossName = "flamethrower_big_boss"
        monsterType1 = "npc_minion_ow_ch2"
        monsterType2 = "npc_minion_ow_ch2"
        interval = math.floor(20/PlAYER_COUNT)
    end
    if NUMBER_OF_WAVE == 7 then
        bossName = "lump_of_flame_big_boss"
        monsterType1 = "npc_minion_ow_ch2"
        monsterType2 = "npc_minion_ow_ch2"
        interval = math.floor(20/PlAYER_COUNT)
    end        
    if NUMBER_OF_WAVE == 10 or NUMBER_OF_WAVE == 13 then
        bossName = "cursed_flame_big_boss"
        monsterType1 = "npc_minion_ow_ch2"
        monsterType2 = "npc_minion_ow_ch2"
        interval = math.floor(20/PlAYER_COUNT)
    end

    Timers:CreateTimer(30, function()
        self:CreateWave(interval, monsterType1, monsterType2, bossName, rollPercType1)

        return nil
    end
    )


end

function main_chap_two:StartNewEvent()
    --print("========================EVENT_REWARD========================")
    EVENT_NUMBER = RandomInt(1,5)
    --EVENT_NUMBER = 2
    local units = nil
    local point = nil
    local modifierName = ""

    if EVENT_REWARD == 0 then
        --print("======================== 0 ========================")
    end

    if EVENT_REWARD == 1 then
        --print("======================== 1 ========================")
        modifierName = GetRandomAlchemyModifierName()
        units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, 7000,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
        
        if units then   
            for i = 1, #units do
                units[i]:AddNewModifier(units[i], nil, modifierName, {duration = WAVE_DURATION})
            end
        end

        EVENT_REWARD = 0      
    end  

    if EVENT_REWARD == 2 then
        --print("======================== 2 ========================")
        point = Entities:FindByName( nil, "trigger_event_colossus"):GetAbsOrigin()
        units = CreateUnitByName("npc_colossus", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
        units:AddNewModifier(units, nil, "modifier_summoner_wide_swing", {})
        units:AddNewModifier(units, nil, "modifier_force_kill", {duration = WAVE_DURATION})
        EVENT_REWARD = 0 
    end

    if EVENT_REWARD == 3 then
        --print("======================== 3 ========================")
        units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, 7000,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
        
        if units then   
            for i = 1, #units do
                if units[i]:GetUnitName() == "npc_lightning_monolith" then
                    units[i]:AddNewModifier(units[i], nil, "modifier_force_kill", {duration = WAVE_DURATION})
                    units[i]:AddNewModifier(units[i], nil, "modifier_npc_invulnerable", {duration = WAVE_DURATION})
                    units[i]:RemoveAbility("enchantment_taunt")
                    units[i]:RemoveModifierByName("modifier_disarmed")
                    units[i]:RemoveModifierByName("modifier_enchantment_taunt")
                end
            end
        end

        EVENT_REWARD = 0  
    end


    if EVENT_REWARD == 4 then
        --print("======================== 4 ========================")
        modifierName = GetRandomAlchemyModifierName()
        units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, 7000,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
        
        if units then   
            for i = 1, #units do
                units[i]:AddNewModifier(units[i], nil, modifierName, {duration = WAVE_DURATION})
            end
        end

        EVENT_REWARD = 0      
    end 

    self:PrepareNewEvent()

end


function main_chap_two:PrepareNewEvent()
    --print("OnEventScorebarVisible") 
    local unit = nil
    local point = nil


    if EVENT_NUMBER == 1 then
        self:SetEventBloodCoinCount(0)
        CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_create_new_message", {messageName = "#event_blood_coin_head", messageText = "#event_blood_coin_text"}) 
        CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = 0, maxScore = 10})
    end


    if EVENT_NUMBER == 2 then
        self:SetEventColossusPartCount(0)
        CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_create_new_message", {messageName = "#event_colossus_head", messageText = "#event_colossus_text"}) 
        CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = 0, maxScore = 5})

        for i = 1, 4 do
            point = Entities:FindByName( nil, "spawner_" .. RandomInt(1, 40)):GetAbsOrigin()
            self:CreateDrop("item_colossus_part", point)
        end
    end


    if EVENT_NUMBER == 3 then
        CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_create_new_message", {messageName = "#event_monolith_head", messageText = "#event_monolith_text"}) 
        for i = 1, 3 do
            point = Entities:FindByName( nil, "spawner_monolith_" .. i):GetAbsOrigin()
            unit = CreateUnitByName("npc_lightning_monolith", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
            unit:AddNewModifier(unit, nil, "modifier_disarmed", {}) 
            --unit:AddNewModifier(unit, nil, "modifier_force_kill", {duration = }) 
        end   
        EVENT_REWARD = 3  
    end


    if EVENT_NUMBER == 4 then
        EVENT_CIRCLE_SCORE = 0
        CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_create_new_message", {messageName = "#event_circle_head", messageText = "#event_circle_text"}) 
        CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = EVENT_CIRCLE_SCORE, maxScore = EVENT_CIRCLE_MAX_SCORE})
        Timers:CreateTimer(5, function()
            for i = 1, #EVENT_CIRCLE_ACTIVE do
                if EVENT_CIRCLE_ACTIVE[i] > 0 then
                    --print("ceil: " .. math.ceil(3/PlAYER_COUNT))
                    EVENT_CIRCLE_SCORE = EVENT_CIRCLE_SCORE + math.ceil(3/PlAYER_COUNT)
                end
            end


            if EVENT_CIRCLE_SCORE >= EVENT_CIRCLE_MAX_SCORE then
                CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_close",  {}) 
                self:SetEventReward(4)
                return nil
            end            
            if CURRENT_MONSTER_COUNT > 0 then
                CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = EVENT_CIRCLE_SCORE, maxScore = EVENT_CIRCLE_MAX_SCORE})
                return 1
            end                       
            return nil
        end
        )
    end


    if EVENT_NUMBER == 5 then
        CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_create_new_message", {messageName = "#event_altar_head", messageText = "#event_altar_text"}) 
        for i = 1, 4 do
            point = Entities:FindByName( nil, "otherkin_world_point_" .. RandomInt(1, 8)):GetAbsOrigin()
            unit = CreateUnitByName("npc_altar", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
            unit:AddNewModifier(unit, nil, GetRandomAuraModifierName(), {}) 
            unit:SetForwardVector(Vector(0,-1,0))
        end   
        EVENT_REWARD = 0  
    end

end

        --CustomGameEventManager:Send_ServerToPlayer(
        --    newHero:GetPlayerOwner(),
        --    "QuestMsgPanel_close",
        --    {}
        --) 