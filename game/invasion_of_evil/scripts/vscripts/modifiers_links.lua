
-------------------------------------------------------------------
------------------------------ITEMS--------------------------------
-------------------------------------------------------------------

LinkLuaModifier("modifier_vortex_axe", "modifiers/vortex_axe/modifier_vortex_axe.lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_vortex_axe_second", "modifiers/vortex_axe/modifier_vortex_axe_second.lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_vortex_axe_third", "modifiers/vortex_axe/modifier_vortex_axe_third.lua", LUA_MODIFIER_MOTION_HORIZONTAL )

-------------------------------------------------------------------
-------------------------MONSTER MODIFIER--------------------------
-------------------------------------------------------------------

LinkLuaModifier("modifier_giant", "modifiers/monsters/modifier_giant.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_weakness_aura", "modifiers/monsters/modifier_weakness_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_weakness_aura_debuff", "modifiers/monsters/modifier_weakness_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_cursed_aura", "modifiers/monsters/modifier_cursed_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_cursed_aura_debuff", "modifiers/monsters/modifier_cursed_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_unity_of_evil", "modifiers/monsters/modifier_unity_of_evil.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_unity_of_evil_mark", "modifiers/monsters/modifier_unity_of_evil.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_frantic", "modifiers/monsters/modifier_frantic.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_thorns", "modifiers/monsters/modifier_thorns.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_distortion_carrier", "modifiers/monsters/modifier_distortion_carrier.lua", LUA_MODIFIER_MOTION_NONE )
-------------------------------------------------------------------

function GetQuestModifierName()
	local ModifName = {	"modifier_quest_absorption",
						"modifier_quest_apply_phys_dmg",
						"modifier_quest_apply_mag_dmg",
						"modifier_quest_kill_sicklyZ",
						"modifier_quest_kill_tightZ",
						"modifier_quest_kill_halfZ",
						"modifier_quest_kill_some_units"}						
	return ModifName[RandomInt(1,#ModifName)]
end
