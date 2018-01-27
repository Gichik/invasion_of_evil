
require( 'main' )
require( 'timers' )
require( 'modifiers_links' )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]

	------------------------------------------------sounds-----------------------------------------------------
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bristleback.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context )
	
	------------------------------------------------models-----------------------------------------------------
	PrecacheResource( "model", "models/heroes/silencer/silencer_curse_skull.vmdl", context )



	------------------------------------------------particles-----------------------------------------------------
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

end

function Activate()

	local MapName = GetMapName()
	print(MapName)

	if MapName == "test_map" then
		print("----------------------------------------Test map Start----------------------------------------")	
		main:InitGameMode()
	end
	
end