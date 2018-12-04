
-------------------------------------------------------------------
------------------------------Settings-----------------------------
-------------------------------------------------------------------

MONSTERS_RESPAWN_TIME = 10
MINI_BOSS_RESPAWN_TIME = 20
START_MONS_RESPAWN_TIME = 10
MINIONS_COUNT = 4
MINIONS_LEVEL = 1
BOSS_MINIONS_COUNT = 13

ENTRAILS_FOR_PORTAL = 3
HEART_FOR_END = 3

--TRAN_GRASS_DROP_PERC = 5
--TRAN_GRASS_FOR_DUNGEON = 3
CHARGES_FOR_JEEPERS_DUNG = 3
CHARGES_FOR_CURSED_DUNG = 3
NOTE_DROP_PERC = 15
TIME_BEFORE_DUNGEON = 120
TREE_RESPAWN_TIME = 60


HEAL_DROP_PERC = 15
SKULL_DROP_PERC = 60
COMMON_DROP_PERC = 20
PROPHECY_DROP_PERC = 30
PROPHECY_ITEM = nil
ENTRAILS_EVIL_DROP_PERC = 30
TIME_BEFORE_REMOVE_DROP = 20

--PORTAL_OW_DURATION = 300    -- OTHERKIN_WORLD
--PORTAL_REPEAT_TIME = 480
PORTAL_REPEAT_TIME = 600
ATTENTION_REPEAT_TIME = 539
LAST_OW_PORTAL_TIME = -120 -- чтобы первый открылся на 8й минуте, а остальные каждую 10ю.
PORTAL_OW_THINK_COUNT = 10
PORTAL_OW_CURRENT_THINK_NUMBER = 1
WAVE_DURATION = 120
BREAK_AFTER_WAVE = 20
TP_PARTICLE_ID = nil
WAVE_STEP = 2;

PORTAL_OW_EXIST = false
WAVE_STATE = false
FINAL_BOSS_STATE = false
BOSS_OW_ELIVE = false
PORTAL_OW_POINT = nil
SPAWNER_OW_POINT = nil
MUSIC_SOURCE = nil


NUMBER_OF_PLAYER = 0
HERO_OF_PLAYER = {nil,nil,nil}


-------------------------------------------------------------------


BOSSES_NAME = { 
        "lump_of_flame_big_boss",
        "flamethrower_big_boss",
        "cursed_flame_big_boss",
        }

FIRST_ITEMS = { 
        "item_helm_resist",
        "item_scapular_mp",
        "item_breastplate_str",
        "item_gloves_dmg",
        "item_belt_hp",
        "item_pants_int",
        "item_boots_agi",
        "item_ring_hp_regen",
        "item_amulet_mp_regen",
        "item_shield_armor"                
        }

SECOND_ITEMS = { 
        "item_helm_resist_second",
        "item_scapular_mp_second",
        "item_breastplate_str_second",
        "item_gloves_dmg_second",
        "item_belt_hp_second",
        "item_pants_int_second",
        "item_boots_agi_second",
        "item_ring_hp_regen_second",
        "item_amulet_mp_regen_second",
        "item_shield_armor_second"              
        } 

THIRD_ITEMS = { 
        "item_helm_resist_third",
        "item_scapular_mp_third",
        "item_breastplate_str_third",
        "item_gloves_dmg_third",
        "item_belt_hp_third",
        "item_pants_int_third",
        "item_boots_agi_third",
        "item_ring_hp_regen_third",
        "item_amulet_mp_regen_third",
        "item_shield_armor_third"                
        } 


UNIQUE_ITEMS = { 
        "item_winged_paladin_gloves",
        "item_armor_gleaming_sea",
        "item_ring_of_the_basilius",
        "item_poor_man_shield",
        "item_amulet_of_conversion",
        "item_protective_amulet"
        }   

function GetRandomItemNameFrom(itemQuality)
    if itemQuality == "first" then
        return FIRST_ITEMS[RandomInt(1,#FIRST_ITEMS)]        
    end

    if itemQuality == "second" then
        return SECOND_ITEMS[RandomInt(1,#SECOND_ITEMS)]        
    end

    if itemQuality == "third" then
        return THIRD_ITEMS[RandomInt(1,#THIRD_ITEMS)]        
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
        {"npc_melee_evil_warrior", "models/creeps/neutral_creeps/n_creep_ogre_med/n_creep_ogre_med.vmdl", 0.7},
        {"npc_range_evil_warrior", "models/creeps/neutral_creeps/n_creep_gargoyle/n_creep_gargoyle.vmdl", 0.6},
        {"npc_melee_evil_warrior", "models/heroes/shadow_demon/shadow_demon.vmdl", 0.9},
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

function SetProphecyItemName(itemName)
    PROPHECY_ITEM = itemName
end

-------------------------------------------------------------------

ACTIVE_MUSIC = true
MUSIC_ID = 1
MUSIC = { 
        {"ShadowHouse", 170, "<font color='#58ACFA'>Music: Luke (Cult of Fire) - Shadow House</font>"},
        {"Diablo2_Cave", nil, "<font color='#58ACFA'>Music: Matt Uelmen - Cave</font>"},
        {"ShadowHouse", 170, "<font color='#58ACFA'>Music: Luke (Cult of Flame) - Shadow House</font>"},
        {"AdrianVonZiegler_FraNordri", nil, "<font color='#58ACFA'>Music: Adrian Von Ziegler - FraNordri</font>"},
        {"ShadowHouse", 170, "<font color='#58ACFA'>Music: Luke (Cult of Fire) - Shadow House</font>"},
        {"AdrianVonZiegler_PathToDarkness", nil, "<font color='#58ACFA'>Music: Adrian Von Ziegler - Path To Darkness</font>"},
        }

--"Invasion_of_evil.ToshiroMasuda_OrochimaruSentou"

function GetMusicByID(id)               
    return MUSIC[id]        
end

function GetMusicCount()               
    return #MUSIC      
end

-------------------------------------------------------------------