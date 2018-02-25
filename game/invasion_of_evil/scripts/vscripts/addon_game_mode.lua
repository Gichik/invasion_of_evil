
require( 'main' )
require( 'timers' )
require( 'modifiers_links' )
require( 'constant_links' )
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





	PrecacheResource( "model", "models/courier/imp/imp_flying.vmdl", context )
	PrecacheResource( "model", "models/courier/smeevil/smeevil_flying.vmdl", context )
	PrecacheResource( "model", "models/items/courier/boooofus_courier/boooofus_courier.vmdl", context )
	


	------------------------------------------------particles-----------------------------------------------------
	
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_legion_commander", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_enigma", context )

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






end

function Activate()

	local MapName = GetMapName()
	print(MapName)

	if MapName == "test_map" then
		print("----------------------------------------Test map Start----------------------------------------")	
		GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_axe');
	end

	if MapName == "forest_map" then
		print("----------------------------------------Forest map Start----------------------------------------")	
		main:InitGameMode()
	end
	
end