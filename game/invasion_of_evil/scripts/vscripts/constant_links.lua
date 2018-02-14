
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
--[[
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
end]]



CEMETERY_MONSTERS = { 
        {"npc_melee_evil_warrior", "models/heroes/undying/undying_minion.vmdl", 0.9},
        {"npc_range_evil_warrior", "models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_b.vmdl", 0.9},
        {"npc_melee_evil_warrior", "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", 1.1},
        {"npc_range_evil_warrior", "models/items/courier/mlg_wraith_courier/mlg_wraith_courier.vmdl", 1.1},
        {"npc_mini_boss", "models/heroes/undying/undying_flesh_golem.vmdl", 1.0}
        } 
CHURCH_MONSTERS = { 
        {"npc_melee_evil_warrior", "models/creeps/neutral_creeps/n_creep_furbolg/n_creep_furbolg_disrupter.vmdl", 0.7},
        {"npc_range_evil_warrior", "models/creeps/neutral_creeps/n_creep_gargoyle/n_creep_gargoyle.vmdl", 0.6},
        {"npc_melee_evil_warrior", "models/creeps/item_creeps/i_creep_necro_warrior/necro_warrior.vmdl", 0.6},
        {"npc_range_evil_warrior", "models/items/courier/dc_demon/dc_demon_flying.vmdl", 0.9},
        {"npc_mini_boss", "models/items/warlock/warlock_fourleg_demon.vmdl", 1.0}
        }   

CURSED_TREE_MONSTERS = { 
        {"npc_melee_evil_warrior", "models/items/courier/little_fraid_the_courier_of_simons_retribution/little_fraid_the_courier_of_simons_retribution.vmdl", 0.9},
        {"npc_range_evil_warrior", "models/creeps/neutral_creeps/n_creep_harpy_b/n_creep_harpy_b.vmdl", 0.7},
        {"npc_melee_evil_warrior", "models/creeps/neutral_creeps/n_creep_satyr_a/n_creep_satyr_a.vmdl", 0.8},
        {"npc_range_evil_warrior", "models/items/courier/deathbringer/deathbringer_flying.vmdl", 0.9},
        {"npc_mini_boss", "models/creeps/lane_creeps/creep_radiant_hulk/creep_radiant_diretide_ancient_hulk.vmdl", 1.0},
        }

function GetUnitFor(biomName,id)
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