
require( 'main' )
require( 'main_chap_two' )
require( 'timers' )
require( 'modifiers_links' )
require( 'constant_links' )
require( 'owLogic' )
require( 'triggers' )
require( 'abilities/ability_helper' )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]

	------------------------------------------------sounds-----------------------------------------------------
	PrecacheResource( "soundfile", "soundevents/invasion_of_evil_sounds_custom.vsndevts", context )

	PrecacheResource( "soundfile", "soundevents/game_sounds_items.vsndevts", context )

	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bristleback.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_necrolyte.vsndevts", context )		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_witchdoctor.vsndevts", context )			
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context )		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_death_prophet.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_chen.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context )			
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_omniknight.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_brewmaster.vsndevts", context )



	------------------------------------------------models-----------------------------------------------------
	PrecacheResource( "model", "models/heroes/silencer/silencer_curse_skull.vmdl", context )
	PrecacheResource( "model", "models/heroes/warlock/warlock.vmdl", context )
	PrecacheResource( "model", "models/props_tree/dire_tree009_tintable.vmdl", context )
	PrecacheResource( "model", "models/props_tree/dire_tree007.vmdl", context )
	PrecacheResource( "model", "models/heroes/undying/undying_minion_torso.vmdl", context ) --npc_half_zombie
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_b.vmdl", context ) --npc_ghost
	PrecacheResource( "model", "models/heroes/undying/undying_minion.vmdl", context ) --npc_zombie
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context )	--npc_skeleton
	PrecacheResource( "model", "models/items/courier/mlg_wraith_courier/mlg_wraith_courier.vmdl", context )	-- npc_nightmare
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_gargoyle/n_creep_gargoyle.vmdl", context ) -- npc_gargoyle
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_furbolg/n_creep_furbolg_disrupter.vmdl", context ) -- npc_demon
	PrecacheResource( "model", "models/creeps/item_creeps/i_creep_necro_warrior/necro_warrior.vmdl", context )	-- npc_fiend	
	PrecacheResource( "model", "models/items/courier/dc_demon/dc_demon_flying.vmdl", context ) -- npc_flying_demon
	PrecacheResource( "model", "models/items/courier/little_fraid_the_courier_of_simons_retribution/little_fraid_the_courier_of_simons_retribution.vmdl", context )	--npc_evil_seed
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_satyr_a/n_creep_satyr_a.vmdl", context ) -- npc_satyr
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_harpy_b/n_creep_harpy_b.vmdl", context ) -- npc_harpy
	PrecacheResource( "model", "models/items/courier/deathbringer/deathbringer_flying.vmdl", context ) -- npc_deathbringer
	PrecacheResource( "model", "models/creeps/lane_creeps/creep_radiant_hulk/creep_radiant_diretide_ancient_hulk.vmdl", context ) -- npc_cursed_tree_boss
	PrecacheResource( "model", "models/heroes/undying/undying_flesh_golem.vmdl", context ) -- npc_cemetery_boss
	PrecacheResource( "model", "models/items/warlock/golem/ahmhedoq/ahmhedoq.vmdl", context ) -- npc_church_boss					
	PrecacheResource( "model", "models/creeps/item_creeps/i_creep_necro_archer/necro_archer.vmdl", context ) -- npc_range_wave_warrior
	PrecacheResource( "model", "models/props_gameplay/salve_red.vmdl", context ) --potion of heal
	PrecacheResource( "model", "models/heroes/legion_commander/legion_commander.vmdl", context ) --npc_guardian
	PrecacheResource( "model", "models/heroes/legion_commander/legion_commander_arms.vmdl", context ) --npc_guardian
	PrecacheResource( "model", "models/heroes/legion_commander/legion_commander_head.vmdl", context ) --npc_guardian
	PrecacheResource( "model", "models/heroes/legion_commander/legion_commander_shoulders.vmdl", context ) --npc_guardian
	PrecacheResource( "model", "models/heroes/legion_commander/legion_commander_weapon.vmdl", context ) --npc_guardian
	PrecacheResource( "model", "models/items/warlock/golem/obsidian_golem/obsidian_golem.vmdl", context ) --lump_of_flame_boss
	PrecacheResource( "model", "models/heroes/warlock/warlock_demon.vmdl", context ) --flamethrower_boss
	PrecacheResource( "model", "models/items/invoker/forge_spirit/esl_relics_forge_spirit/esl_relics_forge_spirit.vmdl", context ) --cursed_flame_boss
	PrecacheResource( "model", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context ) --flame range attack
	PrecacheResource( "model", "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega.vmdl", context ) --npc_minion_ow
	PrecacheResource( "model", "models/props_gameplay/aegis.vmdl", context ) --npc_minion_ow
	PrecacheResource( "model", "models/heroes/nightstalker/nightstalker_night.vmdl", context ) --church monsters
	PrecacheResource( "model", "models/heroes/shadow_demon/shadow_demon.vmdl", context ) --church monsters
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_ogre_med/n_creep_ogre_med.vmdl", context ) --church monsters


	PrecacheResource( "model", "models/props_tree/tree_cine_02_10k.vmdl", context ) --cursed tree
	PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_satyr_c/n_creep_satyr_c.vmdl", context ) --dungeon cursed units
	PrecacheResource( "model", "models/props_gameplay/tango.vmdl", context ) --tran-grass
	PrecacheResource( "model", "models/props_gameplay/tpscroll01.vmdl", context ) --item_note

	PrecacheResource( "model", "models/heroes/tiny_01/tiny_01.vmdl", context ) --npc_mammock
	PrecacheResource( "model", "models/items/tiny/burning_stone_giant_head/burning_stone_giant_head.vmdl", context ) --npc_mammock
	PrecacheResource( "model", "models/items/tiny/burning_stone_giant_body/burning_stone_giant_body.vmdl", context ) --npc_mammock
	PrecacheResource( "model", "models/items/tiny/burning_stone_giant_left_arm/burning_stone_giant_left_arm.vmdl", context ) --npc_mammock
	PrecacheResource( "model", "models/items/tiny/burning_stone_giant_right_arm/burning_stone_giant_right_arm.vmdl", context ) --npc_mammock

	PrecacheResource( "model", "models/heroes/shadow_fiend/shadow_fiend.vmdl", context ) --npc_predator
	PrecacheResource( "model", "models/heroes/shadow_fiend/shadow_fiend_arms.vmdl", context ) --npc_predator
	PrecacheResource( "model", "models/heroes/shadow_fiend/shadow_fiend_head.vmdl", context ) --npc_predator
	PrecacheResource( "model", "models/heroes/shadow_fiend/shadow_fiend_shoulders.vmdl", context ) --npc_predator
	
	PrecacheResource( "model", "models/heroes/puck/puck.vmdl", context ) --npc_aesculapius
	PrecacheResource( "model", "models/heroes/puck/puck_horns.vmdl", context ) --npc_aesculapius
	PrecacheResource( "model", "models/heroes/puck/puck_tail.vmdl", context ) --npc_aesculapius
	PrecacheResource( "model", "models/heroes/puck/puck_wings.vmdl", context ) --npc_aesculapius

	PrecacheResource( "model", "models/courier/imp/imp_flying.vmdl", context )
	PrecacheResource( "model", "models/courier/smeevil/smeevil_flying.vmdl", context )
	PrecacheResource( "model", "models/items/courier/boooofus_courier/boooofus_courier.vmdl", context )
	
	PrecacheResource( "model", "models/items/bounty_hunter/back_jawtrap.vmdl", context ) --jeepers trap
	PrecacheResource( "model", "models/items/furion/treant_flower_1.vmdl", context ) --tree	
	PrecacheResource( "model", "models/heroes/lycan/lycan.vmdl", context ) --vern

	PrecacheResource( "model", "models/items/pugna/ward/weta_call_of_the_nether_lotus_ward/weta_call_of_the_nether_lotus_ward.vmdl", context ) --bush

	PrecacheResource( "model", "models/heroes/wraith_king/wraith_king.vmdl", context ) --fallen commander
	PrecacheResource( "model", "models/items/wraith_king/wk_ti8_creep/wk_ti8_creep.vmdl", context ) --fallen commander minion

	PrecacheResource( "model", "models/props_gameplay/rune_haste01.vmdl", context ) --blood coin
	PrecacheResource( "model", "models/items/warlock/golem/ti9_cache_warlock_tribal_warlock_golem/ti9_cache_warlock_tribal_golem_alt.vmdl", context ) --colossus
	PrecacheResource( "model", "models/props_items/bloodstone.vmdl", context ) --collosus part
	PrecacheResource( "model", "models/props_structures/radiant_tower001.vmdl", context ) --monolith




	------------------------------------------------particles-----------------------------------------------------
	
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_legion_commander", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_enigma", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_witchdoctor", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_bane", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_night_stalker", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_arc_warden", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_pangolier", context )
	--PrecacheResource( "particle_folder", "particles/units/heroes/hero_jakiro", context )


	PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_quills.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_bloody_mid.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf", context )	
	PrecacheResource( "particle", "particles/items_fx/healing_flask.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/weaver/weaver_immortal_ti7/weaver_swarm_infected_debuff_ti7_ground_rings.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength_crit.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_clinkz/clinkz_strafe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf", context )
	PrecacheResource( "particle", "particles/generic_gameplay/generic_stunned.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal_flame.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_necrolyte/necrolyte_spirit_ground_aura.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_ghostship_marker_ripple.vpcf", context )
	PrecacheResource( "particle", "particles/items_fx/healing_clarity_c.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_ring.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_explosion.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf", context )
	PrecacheResource( "particle", "particles/neutral_fx/satyr_hellcaller.vpcf", context ) -- fireball
	PrecacheResource( "particle", "particles/items2_fx/radiance_owner.vpcf", context ) -- burn
	PrecacheResource( "particle", "particles/items2_fx/radiance.vpcf", context ) -- burn
	PrecacheResource( "particle", "particles/neutral_fx/black_dragon_fireball.vpcf", context ) -- crushing_explosion
	PrecacheResource( "particle", "particles/econ/items/antimage/antimage_ti7_golden/antimage_blink_start_ti7_golden_flame.vpcf", context ) -- crushing_explosion
	PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf", context ) -- ice shards spear
	PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf", context ) -- ice shards spear
	PrecacheResource( "particle", "particles/units/heroes/hero_chen/chen_hand_of_god_fallback_mid.vpcf", context ) -- summoner_victim
	PrecacheResource( "particle", "particles/items2_fx/soul_ring_blood.vpcf", context ) -- dishonored_insidious
	PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf", context ) -- dishonored_counterattack
	PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context ) -- templar_blessing
	PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", context ) -- modifier_exile_highlander
	PrecacheResource( "particle", "particles/units/heroes/hero_pugna/pugna_netherblast_fluidexp.vpcf", context ) -- modifier_strychnine_dagger poison
	PrecacheResource( "particle", "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf", context ) -- modifier_strychnine_dagger
	PrecacheResource( "particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context ) -- modifier_jeepers_trap_check
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_loadout.vpcf", context ) -- prophecy
	PrecacheResource( "particle", "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle_soft.vpcf", context ) -- vampire_sower_of_horror
	PrecacheResource( "particle", "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail_circle.vpcf", context ) -- vampire_sower_of_pain
	PrecacheResource( "particle", "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_debuff_echo_demo.vpcf", context ) -- vampire_sucking_life
	PrecacheResource( "particle", "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf", context ) -- modifier_summoner_internal_power_buff
	PrecacheResource( "particle", "particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", context ) -- modifier_summoner_wide_swing
	PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf", context ) -- vampire
	PrecacheResource( "particle", "particles/items2_fx/soul_ring.vpcf", context ) --modif dung church
	PrecacheResource( "particle", "particles/items3_fx/lotus_orb_shell.vpcf", context ) --elementalist shield
	PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context ) --elementalist shield
	PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context ) --elementalist shield
	PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", context ) --elementalist shield
	PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", context ) --elementalist fire
	PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context ) --elementalist fire
	PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_cast.vpcf", context ) --elementalist water
	PrecacheResource( "particle", "endparticles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_debuff.vpcf", context ) --elementalist water


	PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_drops_b.vpcf", context ) --madman bloodthirsty
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context ) --madman bloodthirsty

	PrecacheResource( "particle", "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner_ground.vpcf", context ) --madman bloodthirsty
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", context ) --madman fearless

	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf", context ) --madman destructive




end


function Activate()

	local MapName = GetMapName()
	print(MapName)

	if MapName == "test_map" then
		print("----------------------------------------Test map Start----------------------------------------")	
		--GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
	end

	if (MapName == "chapter_one_easy") or (MapName == "chapter_one_normal") or (MapName == "chapter_one_randomize") then
		print("----------------------------------------chapter_one----------------------------------------")
		main:InitGameMode()
	end

	if MapName == "chapter_two_normal" then
		print("----------------------------------------chapter_two----------------------------------------")
		main_chap_two:InitGameMode()
	end

end