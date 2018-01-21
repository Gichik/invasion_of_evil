if main == nil then
    main = class({})
end
---------------------------------ice modif------------------------------------------------

--LinkLuaModifier( "modifier_directional_move", "modifiers/modifier_directional_move", LUA_MODIFIER_MOTION_HORIZONTAL )

------------------------------------------------------------------------------------------



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

    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self) 
    ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)   
    ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(main, "OnEntityKilled"), self)
    ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(main, 'OnItemPickedUp'), self) 

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
            if unit:HasAnyAvailableInventorySpace() then
                unit:AddItemByName("item_vortex_axe")
                unit:AddItemByName("item_vortex_axe_second")
                unit:AddItemByName("item_vortex_axe_third")
                unit:AddItemByName("item_heart")
                unit:AddItemByName("item_bloodstone")
            end
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
    end 
end

function main:SpanwMoobs()

    local point = Entities:FindByName( nil, "spawner_1"):GetAbsOrigin()
    --for i = 1, 5 do
    local unit = CreateUnitByName("npc_zombie_spawner", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
    unit.vSpawnLoc = unit:GetAbsOrigin()
    unit.firstDie = true
    unit:ForceKill(false)
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