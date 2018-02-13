
-------------------------------------------------------------------
------------------------------Settings-----------------------------
-------------------------------------------------------------------

MONSTERS_RESPAWN_TIME = 5
MINI_BOSS_RESPAWN_TIME = 5
START_MONS_RESPAWN_TIME = 5
MINIONS_COUNT = 4
BOSS_MINIONS_COUNT = 5
PORTAL_OW_DURATION = 10    -- OTHERKIN_WORLD
ENTRAILS_FOR_PORTAL = 2
PORTAL_OW_EXIST = false


PORTAL_OW_POINT = nil
SPAWNER_OW_POINT = nil
-------------------------------------------------------------------

CEMETERY_MONSTERS = { 
        "npc_spawner_zombie",
        "npc_spawner_ghost",
        "npc_spawner_skeleton",
        "npc_spawner_nightmare",
        "npc_cemetery_mini_boss"
        } 
CHURCH_MONSTERS = { 
        "npc_spawner_demon",
        "npc_spawner_gargoyle",
        "npc_spawner_fiend",
        "npc_flying_demon",
        "npc_church_mini_boss"
        }   

CURSED_TREE_MONSTERS = { 
        "npc_spawner_evil_seed",
        "npc_spawner_harpy",
        "npc_spawner_satyr",
        "npc_spawner_deathbringer",
        "npc_cursed_tree_mini_boss"
        }

function GetUnitNameFor(biomName,id)
    if biomName == "cemetery" then
        return CEMETERY_MONSTERS[id]        
    end

    if biomName == "church" then
        return CHURCH_MONSTERS[id]        
    end                     

    if biomName == "cursed_tree" then
        return CURSED_TREE_MONSTERS[id]        
    end
end

