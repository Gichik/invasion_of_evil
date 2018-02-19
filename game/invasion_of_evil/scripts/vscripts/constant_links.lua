
-------------------------------------------------------------------
------------------------------Settings-----------------------------
-------------------------------------------------------------------

MONSTERS_RESPAWN_TIME = 10
MINI_BOSS_RESPAWN_TIME = 30
START_MONS_RESPAWN_TIME = 10
MINIONS_COUNT = 4
BOSS_MINIONS_COUNT = 10
PORTAL_OW_DURATION = 300    -- OTHERKIN_WORLD
ENTRAILS_FOR_PORTAL = 3
HEART_FOR_END = 3

HEAL_DROP_PERC = 30
SKULL_DROP_PERC = 50
COMMON_DROP_PERC = 10
ENTRAILS_EVIL_DROP_PERC = 30
TIME_BEFORE_REMOVE_DROP = 20

WAVE_DURATION = 120
BREAK_AFTER_WAVE = 20

PORTAL_OW_EXIST = false
WAVE_STATE = false
PORTAL_OW_POINT = nil
SPAWNER_OW_POINT = nil
MUSIC_SOURCE = nil
-------------------------------------------------------------------

BOSSES_NAME = { 
        "lump_of_flame_big_boss",
        "flamethrower_big_boss",
        "cursed_flame_big_boss",
        }

START_ITEMS = { 
        "item_unbroken_stallion_gloves",
        "item_toxic_siege_gloves",
        "item_omexe_armor",
        "item_armor_hazhadal",
        "item_ring_of_hp_regen",
        "item_ring_of_mp_regen",
        "item_nil_talisman",
        "item_amulet_of_courage"
        }

COMMON_ITEMS = { 
        "item_unbroken_stallion_gloves",
        "item_unbroken_stallion_gloves_second",
        "item_unbroken_stallion_gloves_third",
        "item_toxic_siege_gloves",
        "item_toxic_siege_gloves_second",
        "item_toxic_siege_gloves_third",
        "item_omexe_armor",
        "item_omexe_armor_second",
        "item_omexe_armor_third",
        "item_armor_hazhadal",
        "item_armor_hazhadal_second",
        "item_armor_hazhadal_third",
        "item_ring_of_hp_regen",
        "item_ring_of_hp_regen_second",
        "item_ring_of_hp_regen_third",
        "item_ring_of_mp_regen",
        "item_ring_of_mp_regen_second",
        "item_ring_of_mp_regen_third",
        "item_nil_talisman",
        "item_nil_talisman_second",
        "item_nil_talisman_third",
        "item_amulet_of_courage",
        "item_amulet_of_courage_second",
        "item_amulet_of_courage_third"
        } 

UNIQUE_ITEMS = { 
        "item_winged_paladin_gloves",
        "item_armor_gleaming_sea",
        "item_ring_of_the_basilius",
        "item_poor_man_shield",
        "item_amulet_of_conversion"
        }   

function GetRandomItemNameFrom(itemQuality)
    if itemQuality == "start" then
        return START_ITEMS[RandomInt(1,#START_ITEMS)]        
    end

    if itemQuality == "common" then
        return COMMON_ITEMS[RandomInt(1,#COMMON_ITEMS)]        
    end

    if itemQuality == "unique" then
        return UNIQUE_ITEMS[RandomInt(1,#UNIQUE_ITEMS)]        
    end
end


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
        {"npc_mini_boss", "models/items/warlock/golem/ahmhedoq/ahmhedoq.vmdl", 1.0}
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