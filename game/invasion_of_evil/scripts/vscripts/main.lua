if main == nil then
    main = class({})
end

--npc_spawner_bush_1
--npc_spawner_alchemist_1
--CustomGameEventManager

function main:InitGameMode()
   --print( "InitGameMode" )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

    GameRules:SetUseUniversalShopMode( false )
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
    GameRules:GetGameModeEntity():SetFixedRespawnTime(30)
    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)


    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_rubick');
    --GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_dragon_knight');

    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(main, "DamageFilter"), self) 

    if GetMapName() == "chapter_one_randomize" then
        RANDOMIZE_MODE = true
    end


    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self) 
    --ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)   
    ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(main, "OnEntityKilled"), self)
    ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(main, 'OnItemPickedUp'), self) 
    ListenToGameEvent( "player_chat", Dynamic_Wrap( main, "OnChat" ), self )

    if not RANDOMIZE_MODE then
        ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(main, 'OnAbilityLearned'), self) 
    end


    CustomGameEventManager:RegisterListener( "quest_cursed_activate", Dynamic_Wrap( main, "OnQuestCursedActivate" ))
    CustomGameEventManager:RegisterListener( "quest_church_activate", Dynamic_Wrap( main, "OnQuestChurchActivate" ))
    CustomGameEventManager:RegisterListener( "quest_alchemy_activate", Dynamic_Wrap( main, "OnQuestAlchemyActivate" ))
    CustomGameEventManager:RegisterListener( "quest_help_activate", Dynamic_Wrap( main, "OnQuestHelpActivate" ))

    PORTAL_OW_POINT = Entities:FindByName( nil, "trigger_teleport"):GetAbsOrigin()
    SPAWNER_OW_POINT = Entities:FindByName( nil, "otherkin_world_spawner"):GetAbsOrigin()

    AddFOWViewer(DOTA_TEAM_GOODGUYS, Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin(), 2000, -1, false)
    --self:TestBosses()
    self:SpanwMoobs()
end

function main:SetPortalOwExist(flag)
    PORTAL_OW_EXIST = flag
end

function main:SetWaveState(flag)
    WAVE_STATE = flag
end

function main:SetBossOwStatus(flag)
    BOSS_OW_ELIVE = flag
end

function main:SetFinalState(flag)
    FINAL_BOSS_STATE = flag
end

function main:ApplyMusicOn(soundName,hSource)
    --print("SetMusicSource")
    MUSIC_SOURCE = hSource
    StartSoundEvent(soundName,hSource)
end

function main:GameRulesStateChange(data)
    local newState = GameRules:State_Get()

    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        --GameRules:SendCustomMessageToTeam("#start_necromancer_message_2", DOTA_TEAM_GOODGUYS, 0, 0)
        if ACTIVE_MUSIC then
           EmitGlobalSound("Invasion_of_evil.AdrianVonZiegler_ReignOfTheDark")
            --GameRules:SendCustomMessage("<font color='#58ACFA'>Luka - Shadow House(skyrim mods)</font>", 0, 0)
            GameRules:SendCustomMessage("<font color='#58ACFA'>Music: Adrian Von Ziegler - Reign Of The Dark</font>", 0, 0)
        end
        --GameRules:SendCustomMessage("#start_game", 0, 0)        
        CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#start_messages_name", messageText = "#start_game"})
        self:CreateInceptionWaves()        
        StartOwTimer()
        --StartHelpMessagesTimer() 
        --self:StartMusicTimer()       
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


            if RANDOMIZE_MODE then
                CreateRandomizeAbility(unit)
            else
                local ability = nil
                for i = 0, 3 do
                    ability = unit:GetAbilityByIndex(i)
                    if ability then
                        ability:SetLevel(1)
                    end 
                end               
            end


     
            if unit:HasAnyAvailableInventorySpace() then
                --unit:AddItemByName("item_ice_shards_spear")
                --unit:AddItemByName("item_blink")
                --unit:AddItemByName("item_heart")
                --unit:AddItemByName("item_note_alchemist_one")
                --unit:AddItemByName("item_heart_of_evil")
                --unit:AddItemByName("item_heart_of_evil")
                --unit:AddItemByName("item_heart_of_evil")
            end

            if GetMapName() == "chapter_one_easy" then
                unit:AddNewModifier(unit, nil, "modifier_easy_mode_buff", {})
            end

        end
    end

end


function main:OnAbilityLearned(data)
    --print("OnAbilityLearned")
    local hHero = PlayerResource:GetPlayer(data.PlayerID):GetAssignedHero() or nil
    local ability = hHero:FindAbilityByName(data.abilityname)
    local pathName = nil

    if ability:GetLevel() <= 1 then
        if not data.abilityname:find("special_bonus") then
            if data.abilityname:find("berserk") then
                pathName = "berserk"
            end
            if data.abilityname:find("exile") then
                pathName = "exile"
            end            
            if data.abilityname:find("templar") then
                pathName = "templar"
            end 
            if data.abilityname:find("dishonored") then
                pathName = "dishonored"
            end              
            if data.abilityname:find("sapient") then
                pathName = "sapient"
            end              
            if data.abilityname:find("summoner") then
                pathName = "summoner"
            end  
            if data.abilityname:find("vampire") then
                pathName = "vampire"
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

--player, level,splitscreenplayer
function main:OnPlayerGainedLevel(data)
    local hPlayer = EntIndexToHScript(data.player)
    local hHero = hPlayer:GetAssignedHero()
    --[[if hHero:GetLevel() > 20 and hHero:GetLevel() < 25 then 
        hHero:SetAbilityPoints(hHero:GetAbilityPoints() + 1)
    end]]
end


function main:OnSomeHeroKilled(data)

end


----entindex_attacker,entindex_killed,damagebits,splitscreenplayer

function main:OnEntityKilled(data)
    
    local killedEntity = EntIndexToHScript(data.entindex_killed)
    local attackerEntity = EntIndexToHScript(data.entindex_attacker)

    if killedEntity:IsCreature()  then

        if killedEntity:GetUnitName() == "npc_necromant_base" then
            --GameRules:SendCustomMessageToTeam("#necromancer_die", DOTA_TEAM_GOODGUYS, 0, 0)
            CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "", messageText = "#necromancer_die"})
            GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
        end

        if killedEntity:GetTeamNumber() == DOTA_TEAM_NEUTRALS then


            if killedEntity:GetUnitName() == "final_boss" then
                --GameRules:SendCustomMessageToTeam("#final_boss_die", DOTA_TEAM_GOODGUYS, 0, 0)
                CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "", messageText = "#final_boss_die"})
                GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
            end

            if RollPercentage(HEAL_DROP_PERC) then
                self:CreateDrop("item_potion_of_heal", killedEntity:GetAbsOrigin())
            end

            if RollPercentage(HEAL_DROP_PERC) then
                self:CreateDrop("item_potion_of_mana", killedEntity:GetAbsOrigin())
            end            

            if killedEntity:GetUnitName() == "npc_inception_attacker_evil_warrior" then
                if RollPercentage(COMMON_DROP_PERC/4) then
                    self:CreateDrop(GetRandomItemNameFrom("first"), killedEntity:GetAbsOrigin())
                end

                if RollPercentage(SKULL_DROP_PERC) then
                    self:CreateDrop("item_skull_of_evil", killedEntity:GetAbsOrigin())
                end 
            end

            if killedEntity:GetUnitName():find("npc_start_ghost_")  then
                if RollPercentage(COMMON_DROP_PERC) then
                     self:CreateDrop(GetRandomItemNameFrom("second"), killedEntity:GetAbsOrigin())
                end
            end


            if not killedEntity:GetUnitName():find("wave") 
                and not killedEntity:GetUnitName():find("npc_start_ghost_") 
                and killedEntity:GetUnitName() ~= "npc_inception_attacker_evil_warrior"
                and killedEntity:GetUnitName() ~= "npc_minion_ow"
                and killedEntity:GetUnitName() ~= "npc_cursed_minion"
                and killedEntity:GetUnitName() ~= "npc_jeepers_minion"
                and killedEntity:GetUnitName() ~= "npc_jeepers_trap"
                and killedEntity:GetUnitName() ~= "npc_tree"
                and not killedEntity:GetUnitName():find("bush")                
                and not killedEntity:GetUnitName():find("boss") then

                if RollPercentage(SKULL_DROP_PERC) then
                    self:CreateDrop("item_skull_of_evil", killedEntity:GetAbsOrigin())
                end

                if RollPercentage(COMMON_DROP_PERC) then
                    if killedEntity:GetUnitName():find("start") then
                        self:CreateDrop(GetRandomItemNameFrom("first"), killedEntity:GetAbsOrigin())
                    else
                        self:CreateDrop(GetRandomItemNameFrom("second"), killedEntity:GetAbsOrigin())
                    end
                end


                --if not killedEntity:GetUnitName():find("start") then
                --    if RollPercentage(TRAN_GRASS_DROP_PERC) then
                --        self:CreateDrop("item_tran_grass", killedEntity:GetAbsOrigin())
                --    end                    
                --end

                if killedEntity:GetUnitName():find("start") then
                    if RollPercentage(NOTE_DROP_PERC) then
                        --self:CreateDrop("item_note_" .. RandomInt(1,3), killedEntity:GetAbsOrigin())
                        local variation = RandomInt(1, 3)

                        if variation == 1 then
                            self:CreateDrop("item_note_dungeon_cursed_one", killedEntity:GetAbsOrigin())
                        end

                        if variation == 2 then
                            self:CreateDrop("item_note_dungeon_jeepers_one", killedEntity:GetAbsOrigin())
                        end   

                        if variation == 3 then
                            self:CreateDrop("item_note_alchemist_one", killedEntity:GetAbsOrigin())
                        end
                    end                                  
                end

            end

            if killedEntity:GetUnitName():find("mini_boss") then
                self:RespawnMiniBoss(killedEntity:GetUnitName(), killedEntity.modelName, killedEntity.modelScale, killedEntity.vSpawnLoc, MINI_BOSS_RESPAWN_TIME)
                
                self:CreateDrop(GetRandomItemNameFrom("third"), killedEntity:GetAbsOrigin())
                
                --if RollPercentage(ENTRAILS_EVIL_DROP_PERC) then
                    --self:CreateDrop("item_entrails_evil", killedEntity:GetAbsOrigin())
                --end 
                --if RollPercentage(10) then
                --    self:CreateDrop(GetRandomItemNameFrom("unique"), killedEntity:GetAbsOrigin())
                --end        
            end  

            if killedEntity:GetUnitName():find("big_boss") then
                
                self:CreateDrop("item_heart_of_evil", killedEntity:GetAbsOrigin())
                self:CreateDrop(GetRandomItemNameFrom("unique"), killedEntity:GetAbsOrigin())
            
                self:SetBossOwStatus(false)

                --GameRules:SendCustomMessageToTeam("#teleport_back", DOTA_TEAM_GOODGUYS, 0, 0)
                CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#necromancer_message_name", messageText = "#teleport_back"})
                Timers:CreateTimer(15, function()
                    self:ApplyBackTeleport() 
                    return nil
                end
                )                
                      
            end

            if killedEntity:GetUnitName():find("dungeon_boss") then
                local dropItemName = GetRandomItemNameFrom("unique")

                if PROPHECY_ITEM then 
                    dropItemName = PROPHECY_ITEM
                    PROPHECY_ITEM = nil
                end

                if attackerEntity.iProphecyName == dropItemName then
                    attackerEntity:EmitSound("Item.LotusOrb.Activate")
                    attackerEntity:RemoveModifierByName(attackerEntity.mProphecyName)
                end

                self:CreateDrop(dropItemName, killedEntity:GetAbsOrigin())
                self:CreateDungeonFor(killedEntity:GetUnitName(),TIME_BEFORE_DUNGEON)                    
            end
  
           --[[ if killedEntity.biomName then
                if killedEntity.biomName == "cursed_tree" then
                    if RollPercentage(TRAN_GRASS_DROP_PERC) then
                        self:CreateDrop("item_tran_grass", killedEntity:GetAbsOrigin())
                    end                      
                end
            end]] 

            if killedEntity.spawner then
                if killedEntity:GetUnitName():find("start") then
                    self:RespawnStartUnits( killedEntity.vSpawnLoc,
                                            MINIONS_COUNT,
                                            START_MONS_RESPAWN_TIME)
                elseif killedEntity:GetUnitName() == "npc_tree" then
                    self:RespawnEnvironmentUnits( killedEntity:GetUnitName(),
                                            killedEntity.vSpawnLoc,
                                            false,
                                            TREE_RESPAWN_TIME,
                                            nil)
                elseif killedEntity:GetUnitName() == "npc_bush" then
                    local color = RandomInt(1, 3)
                    local modifierName = "modifier_color_red"
                    if color == 2 then
                        modifierName = "modifier_color_green"
                    end
                    if color == 3 then
                        modifierName = "modifier_color_blue"
                    end

                    self:RespawnEnvironmentUnits( killedEntity:GetUnitName(),
                                            killedEntity.vSpawnLoc,
                                            false,
                                            TREE_RESPAWN_TIME,
                                            modifierName)
                elseif killedEntity:GetUnitName() == "npc_minion_ow" then
                    self:RespawnMinionOWUnits(15)
                else
                    self:RespawnUnits(  killedEntity:GetUnitName(), 
                                        killedEntity.modelName, 
                                        killedEntity.modelScale, 
                                        killedEntity.vSpawnLoc,
                                        MINIONS_COUNT,
                                        MONSTERS_RESPAWN_TIME,
                                        killedEntity.biomName)
                end
            end

        end
    end 

    if killedEntity:IsRealHero()  then
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

        if haveProtect == false then
            main:GiveNewHero(killedEntity)
        end
    end    
end

function main:SpanwMoobs()

    local point = nil
    local unit = nil

    point = Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin()
    unit = CreateUnitByName("npc_necromant_base", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(0,-1,0))
    --self:ApplyMusicOn("Invasion_of_evil.ShadowHouse",unit)

    point = Entities:FindByName( nil, "npc_spawner_5"):GetAbsOrigin()
    unit = CreateUnitByName("npc_vern_base", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(-1,0,0))

    point = Entities:FindByName( nil, "npc_spawner_2" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(-1,-1,0))

    point = Entities:FindByName( nil, "npc_spawner_3" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(1,-1,0))

    point = Entities:FindByName( nil, "npc_spawner_4" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_guardian", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
    unit:SetForwardVector(Vector(0,1,0))

    point = Entities:FindByName( nil, "npc_spawner_alchemist_1" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_alchemist_tombstone", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
    unit:SetForwardVector(Vector(0,1,0))

    point = Entities:FindByName( nil, "npc_spawner_alchemist_2" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_alchemist_table", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
    unit:SetForwardVector(Vector(0,1,0))

    point = Entities:FindByName( nil, "npc_spawner_alchemist_3" ):GetAbsOrigin()
    unit = CreateUnitByName("npc_alchemist_book", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
    unit:SetForwardVector(Vector(0,1,0))


    for i = 1, 3 do
        point = Entities:FindByName( nil, "start_monster_spawner_" .. i ):GetAbsOrigin()
        self:RespawnStartUnits( point, MINIONS_COUNT, 1)
    end

    for i = 6, 15 do
        if i ~= 12 and i ~= 13 then
            point = Entities:FindByName( nil, "cursed_tree_spawner_" .. i ):GetAbsOrigin()
            self:RespawnEnvironmentUnits("npc_tree", point, false, 1, nil)
        end
    end

    for i = 1, 15 do
        local color = RandomInt(1, 3)
        local modifierName = "modifier_color_red"
        if color == 2 then
            modifierName = "modifier_color_green"
        end
        if color == 3 then
            modifierName = "modifier_color_blue"
        end        
        point = Entities:FindByName( nil, "npc_spawner_bush_" .. i ):GetAbsOrigin()
        self:RespawnEnvironmentUnits("npc_bush", point, false, 1, modifierName)
    end

    for i = 1, 5 do
        self:CreateUnits("cemetery", i, 1)
        self:CreateUnits("church", i, 1)
        self:CreateUnits("cursed_tree", i, 1)     
    end 

    self:CreateDungeonFor("dungeon_boss_cursed",5) 
    self:CreateDungeonFor("dungeon_boss_jeepers",5)     
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
                self:RespawnUnits(unitSettings[1], unitSettings[2], unitSettings[3], point, MINIONS_COUNT, time, biomName)   
            end      
        end
    end
end

function main:CreateDungeonFor(bossName,time)
    --print("CreateUnits")
    if bossName and time then

        Timers:CreateTimer(time, function()
            local biomName = nil
            local spawnerCount = nil
            local point = nil
            local unit = nil
            --npc_minion_ow
            if bossName == "dungeon_boss_cursed" then
                biomName = "cursed"
                spawnerCount = 11
                GameRules:SendCustomMessage("#witch_reincarnated", 0, 0)
            
                point = Entities:FindByName( nil, biomName .. "_dungeon_spawner_1" ):GetAbsOrigin()
                unit = CreateUnitByName(bossName, point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})        
                for i = 2, spawnerCount do
                    point = Entities:FindByName( nil, biomName .. "_dungeon_spawner_" .. i ):GetAbsOrigin()
                    unit = CreateUnitByName("npc_cursed_minion", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                    unit = CreateUnitByName("npc_cursed_minion", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                    unit = CreateUnitByName("npc_cursed_minion", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                end
            end

            if bossName == "dungeon_boss_jeepers" then
                biomName = "jeepers"
                spawnerCount = 5
                GameRules:SendCustomMessage("#jeepers_reincarnated", 0, 0)
            
                point = Entities:FindByName( nil, biomName .. "_dungeon_spawner_1" ):GetAbsOrigin()

                local units = FindUnitsInRadius( DOTA_TEAM_NEUTRALS, point, nil, 2000,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
                
                if units then   
                    for i = 1, #units do
                        UTIL_Remove(units[i])
                    end
                end
               
                unit = CreateUnitByName(bossName, point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                unit:AddNewModifier(unit, nil, "modifier_replacement_of_organs", {})
                --unit:AddNewModifier(unit, nil, "modifier_jeepers_trap", {})
                
                for i = 2, spawnerCount do
                    point = Entities:FindByName( nil, biomName .. "_dungeon_spawner_" .. i ):GetAbsOrigin()
                    unit = CreateUnitByName("npc_jeepers_minion", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                end


                for i = spawnerCount, 18 do
                    point = Entities:FindByName( nil, biomName .. "_dungeon_spawner_" .. i ):GetAbsOrigin()
                    unit = CreateUnitByName("npc_jeepers_trap", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
                    unit:AddNewModifier(unit, nil, "modifier_jeepers_trap", {})
                    unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
                    unit:AddNewModifier(unit, nil, "modifier_invisible", {})
                end                
            end

            return nil
        end
        )
    end
end


function main:RespawnEnvironmentUnits(unitName,SpawnLoc,healthbar,time,modifierName)
    
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    local directionX = RandomInt(0, 1)
    local directionY = RandomInt(0, 1)

    if directionX == 0 then
        directionX = -1 
    end

    if directionY == 0 then
        directionY = -1
    end
    
    Timers:CreateTimer(time, function()
        unit = CreateUnitByName(unitName, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 
        unit.spawner = true
        if not healthbar then
           unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
        end

        if modifierName then
            unit:AddNewModifier(unit, nil, modifierName, {})
        end
        unit:SetForwardVector(Vector(directionX,directionY,0))

      return nil
    end
    )
end


function main:RespawnStartUnits(SpawnLoc,numMinions,time)
    
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    local name = "npc_start_ghost_" .. RandomInt(1, 3)

    Timers:CreateTimer(time, function()

        unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, team )
        unit.vSpawnLoc = SpawnLoc 
        unit.spawner = true
        unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})

        for i = 1, numMinions do 
            unit = CreateUnitByName("npc_start_evil_warrior", SpawnLoc + RandomVector(100), true, nil, nil, team )
        end

      return nil
    end
    )
end


function main:RespawnUnits(unitName,modelName,modelScale,SpawnLoc,numMinions,time,biomName)
    
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
        unit.biomName = biomName

        local modifier = unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})

        for i = 1, numMinions do 
            unit = CreateUnitByName(unitName, SpawnLoc + RandomVector(100), true, nil, nil, team )
            unit:SetOriginalModel(modelName)
            unit:SetModelScale(modelScale)
            unit.spawner = false
            unit.biomName = biomName
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


function main:RespawnMinionOWUnits(time)

    local unit = nil
    
    Timers:CreateTimer(time, function()

        if SPAWNER_OW_POINT and PORTAL_OW_EXIST and BOSS_OW_ELIVE then
            unit = CreateUnitByName("npc_minion_ow", SPAWNER_OW_POINT + RandomVector(700), true, nil, nil, DOTA_TEAM_NEUTRALS )
            unit:CreatureLevelUp(MINIONS_LEVEL - 1)
            unit.spawner = true
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
        newHero = PlayerResource:ReplaceHeroWith(playerID, oldHero:GetName(), oldHero:GetGold(), oldHero:GetCurrentXP())
       
        if oldHero:HasModifier("modifier_quest_dungeon_jeepers") then
            newHero:AddNewModifier(newHero, nil, "modifier_quest_dungeon_jeepers", {})
        end

        if oldHero:HasModifier("modifier_quest_dungeon_cursed") then
            newHero:AddNewModifier(newHero, nil, "modifier_quest_dungeon_cursed", {})
        end

        if oldHero:HasModifier("modifier_alchemy") then
            newHero:AddNewModifier(newHero, nil, "modifier_alchemy", {})
        end

        if oldHero:HasModifier("modifier_achievement_ghostbusters") then
            newHero:AddNewModifier(newHero, nil, "modifier_achievement_ghostbusters", {})
        end

        UTIL_Remove(oldHero)
        newHero:RespawnHero(false, false)

        CustomGameEventManager:Send_ServerToPlayer(
            newHero:GetPlayerOwner(),
            "QuestMsgPanel_close",
            {}
        )       

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
            ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
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


function main:ApplyBackTeleport()
    local units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, nil, 2000,
    DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
    
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


function main:StartHelpMessagesTimer()

    local helpMessageNumber = 0

    Timers:CreateTimer(20, function()
        helpMessageNumber = helpMessageNumber + 1
        if helpMessageNumber <= 9 then
            --GameRules:SendCustomMessage("#help_messages_" .. helpMessageNumber, 0, 0)
            CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#help_messages_name", messageText = "#help_messages_" .. helpMessageNumber})
            return 11
        end

        return nil
    end
    )   

    --Timers:CreateTimer(WAVE_DURATION + 5, function()
    --    CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#help_messages_name", messageText = "#help_messages_10"})
        --GameRules:SendCustomMessage("#help_messages_10", 0, 0)
    --    return nil 
    -- end)

end


function main:CreateInceptionWaves()
    local point = nil
    local waveCount = WAVE_DURATION 
    local unit = nil

    WAVE_STEP = 7 - PlayerResource:GetTeamPlayerCount()

    Timers:CreateTimer(1, function()
        if waveCount > 0 then
            for i = 1, 6 do
                point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
                unit = CreateUnitByName("npc_inception_attacker_evil_warrior", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
            end

            waveCount = waveCount - WAVE_STEP
            
            return WAVE_STEP
        end

        if waveCount <= 0 then
            --GameRules:SendCustomMessage("#start_necromancer_message_1", 0, 0)
            CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#necromancer_message_name", messageText = "#start_necromancer_message_1"})
            if ACTIVE_MUSIC then
                EmitGlobalSound("Invasion_of_evil.AdrianVonZiegler_DeathDance")
                GameRules:SendCustomMessage("<font color='#58ACFA'>Music: Adrian Von Ziegler - Death Dance</font>", 0, 0)
            end
            return nil
        end
        
    end
    )
end


--playerid,text,teamonly,userid,splitscreenplayer
function main:OnChat( data )

    local player = PlayerResource:GetPlayer(data.playerid) 
    local text = data.text

    if text == "-onmusic" then
        ACTIVE_MUSIC = true
        GameRules:SendCustomMessage("Music ON", 0, 0) 
    end

    if text == "-offmusic" then
        ACTIVE_MUSIC = false
        GameRules:SendCustomMessage("Music OFF", 0, 0) 
        self:StopAllMusic(player)
    end

    if text == "-stopmusic" then
        print("-stopmusic")
        --player:StopSound("Invasion_of_evil.AdrianVonZiegler_DeathDance")
        --StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_DeathDance",player)
        self:StopAllMusic(player)
    end

    if text == "-newMessage" then
        print("-newMessage")
        --player:StopSound("Invasion_of_evil.AdrianVonZiegler_DeathDance")
        --StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_DeathDance",player)
        --CustomGameEventManager:Send_ServerToAllClients("MessagePanel_create_new_message", {messageName = "#necromancer_message_name", messageText = "#start_necromancer_message_1"})
    end


    if text == "-removeMessage" then
        print("-removeMessage")
        --player:StopSound("Invasion_of_evil.AdrianVonZiegler_DeathDance")
        --StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_DeathDance",player)
        --CustomGameEventManager:Send_ServerToAllClients("quests_remove_message", {text = "hello"})
    end

    --print("StopSound")
    --EmitGlobalSound("Item.DropWorld")
    --StopSoundEvent("Invasion_of_evil.Nocturnus",player)
    --player:StopSound("Invasion_of_evil.Nocturnus")
    --StopSoundEvent("Invasion_of_evil.ShadowHouse",MUSIC_SOURCE)
    --StopSoundEvent("Invasion_of_evil.EpicFight1",MUSIC_SOURCE)

end

function main:StopAllMusic(hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_ReignOfTheDark",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_DeathDance",hPlayer)
    StopSoundEvent("Invasion_of_evil.EpicFight1",hPlayer)

    StopSoundEvent("Invasion_of_evil.Diablo2_Cave",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_BlackenedRoots",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_FraNordri",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_Einherjer",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_BoneTemple",hPlayer)
    StopSoundEvent("Invasion_of_evil.AdrianVonZiegler_PathToDarkness",hPlayer)                              
end



function main:TestBosses()
    local unit = CreateUnitByName("cursed_flame_boss", SPAWNER_OW_POINT, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})

    --unit:SetAbsOrigin(Entities:FindByName( nil, "hero_teleport_spawner"):GetAbsOrigin())
end


function main:StartMusicTimer()

    local musicTable = GetMusicByID(1)


    Timers:CreateTimer(1, function()

        if MUSIC_ID >= GetMusicCount() then
            MUSIC_ID = 1
        end

        musicTable = GetMusicByID(MUSIC_ID)
        if ACTIVE_MUSIC then
            EmitGlobalSound("Invasion_of_evil." .. musicTable[1])
            GameRules:SendCustomMessage(musicTable[3], 0, 0) 
        end 
        MUSIC_ID = MUSIC_ID + 1  
        return musicTable[2]
    end)

end


function main:OnQuestCursedActivate(data)
    --print("OnQuestCursedActivate")
    --print(data.PlayerID)

    local hPlayer = PlayerResource:GetPlayer(data.PlayerID)
    if hPlayer then
        local hHero = hPlayer:GetAssignedHero()
        if hHero and hHero.cursed_step then

            ------------------------------------------------------------------------------------
            if hHero.cursed_step == 1 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_vern_base" then
                            hHero.cursed_step = 2
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_cursed_dungeon", messageText = "#note_dungeon_cursed_two_Description", quest = "cursed", questClose = false}
                            ) 
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_cursed_dungeon", messageText = "#note_dungeon_vern_Description", quest = "cursed", questClose = false}
                ) 
                return nil            
            end 

            ------------------------------------------------------------------------------------
            if hHero.cursed_step == 2 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_necromant_base" then
                            hHero.cursed_step = 3
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_cursed_dungeon", messageText = "#note_dungeon_cursed_three_Description", quest = "cursed", questClose = true}
                            )
                            hHero:AddNewModifier(hHero, nil, "modifier_quest_dungeon_cursed", {}) 
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_cursed_dungeon", messageText = "#note_dungeon_necromant_Description", quest = "cursed", questClose = false}
                ) 
                return nil            
            end 
            ------------------------------------------------------------------------------------
        end
    end
end



function main:OnQuestChurchActivate(data)

    local hPlayer = PlayerResource:GetPlayer(data.PlayerID)
    if hPlayer then
        local hHero = hPlayer:GetAssignedHero()
        if hHero and hHero.church_step then

            ------------------------------------------------------------------------------------
            if hHero.church_step == 1 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_vern_base" then
                            hHero.church_step = 2
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_church_dungeon", messageText = "#note_dungeon_church_two_Description", quest = "church", questClose = false}
                            ) 
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_church_dungeon", messageText = "#note_dungeon_vern_Description", quest = "church", questClose = false}
                ) 
                return nil            
            end 

            ------------------------------------------------------------------------------------
            if hHero.church_step == 2 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_necromant_base" then
                            hHero.church_step = 3
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_church_dungeon", messageText = "#note_dungeon_church_three_Description", quest = "church", questClose = true}
                            )
                            hHero:AddNewModifier(hHero, nil, "modifier_quest_dungeon_jeepers", {}) 
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_church_dungeon", messageText = "#note_dungeon_necromant_Description", quest = "church", questClose = false}
                ) 
                return nil            
            end 
            ------------------------------------------------------------------------------------
        end
    end
end



function main:OnQuestAlchemyActivate(data)

    local hPlayer = PlayerResource:GetPlayer(data.PlayerID)
    if hPlayer then
        local hHero = hPlayer:GetAssignedHero()
        if hHero and hHero.alchemy_step then

            ------------------------------------------------------------------------------------
            if hHero.alchemy_step == 1 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_vern_base" then
                            hHero.alchemy_step = 2
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_two_Description", quest = "alchemy", questClose = false}
                            ) 
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_alchemy_quest", messageText = "#note_dungeon_vern_Description", quest = "alchemy", questClose = false}
                ) 
                return nil            
            end 

            ------------------------------------------------------------------------------------
            if hHero.alchemy_step == 2 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_alchemist_tombstone" then
                            hHero.alchemy_step = 3
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_three_Description", quest = "alchemy", questClose = false}
                            )
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_next_one_Description", quest = "alchemy", questClose = false}
                ) 
                return nil            
            end 
            ------------------------------------------------------------------------------------
            if hHero.alchemy_step == 3 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_alchemist_table" then
                            hHero.alchemy_step = 4
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_fourth_Description", quest = "alchemy", questClose = false}
                            )
                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_next_two_Description", quest = "alchemy", questClose = false}
                ) 
                return nil            
            end 
            ------------------------------------------------------------------------------------
            if hHero.alchemy_step == 4 then
                local units = FindUnitsInRadius( hHero:GetTeamNumber(), hHero:GetAbsOrigin(), hHero, 300,
                DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
                
                if units then
                    for i = 1, #units do
                        if units[ i ] :GetUnitName() == "npc_alchemist_book" then
                            hHero.alchemy_step = 5
                            hHero:EmitSound("Item.TomeOfKnowledge")
                            CustomGameEventManager:Send_ServerToPlayer(
                                hHero:GetPlayerOwner(),
                                "QuestMsgPanel_create_new_message",
                                {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_fifth_Description", quest = "alchemy", questClose = true}
                            )
                            hHero:AddNewModifier(hHero, nil, "modifier_alchemy", {}) 

                            local point = Entities:FindByName( nil, "npc_spawner_alchemist_3" ):GetAbsOrigin()
                            local unit = CreateUnitByName("npc_alchemist_ghost", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
                            unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
                            unit:AddNewModifier(unit, nil, "modifier_npc_invulnerable", {})
                            unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 15})
                            unit:SetForwardVector(Vector(1,-1,0))


                            return nil                       
                        end
                    end
                end

                CustomGameEventManager:Send_ServerToPlayer(
                    hHero:GetPlayerOwner(),
                    "QuestMsgPanel_create_new_message",
                    {messageName = "#note_alchemy_quest", messageText = "#note_alchemy_next_three_Description", quest = "alchemy", questClose = false}
                ) 
                return nil            
            end 
            ------------------------------------------------------------------------------------

        end
    end
end



function main:OnQuestHelpActivate(data)
    --print("OnQuestHelpActivate")
    local hPlayer = PlayerResource:GetPlayer(data.PlayerID)
    if hPlayer then

        if not hPlayer.helpMsgNumb or hPlayer.helpMsgNumb >= 11 then
             hPlayer.helpMsgNumb = 1
        else
            hPlayer.helpMsgNumb = hPlayer.helpMsgNumb + 1
        end

        CustomGameEventManager:Send_ServerToPlayer(hPlayer,"QuestMsgPanel_create_new_message", {
            messageName = "#help_messages_name", 
            messageText = "#help_messages_" .. hPlayer.helpMsgNumb
            })         

    end
end