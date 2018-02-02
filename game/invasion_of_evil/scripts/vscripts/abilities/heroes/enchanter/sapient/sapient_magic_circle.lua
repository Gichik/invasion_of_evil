
if sapient_magic_circle == nil then
	sapient_magic_circle = class({})
end

function sapient_magic_circle:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function sapient_magic_circle:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function sapient_magic_circle:GetAOERadius()
	return self:GetSpecialValueFor( "aoe_radius" )
end

--в кастера величину регена положил, а так же точку каста, иначе мороки много
function sapient_magic_circle:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local point = self:GetCursorPosition()
		local dur = self:GetSpecialValueFor("duration")
		if caster and point then
			caster.magic_circle_point = point
			caster.magic_circle_regen = self:GetSpecialValueFor("bonus_regen")
			CreateModifierThinker( caster, self, "modifier_sapient_magic_circle", {duration = dur}, point, caster:GetTeamNumber(), true)
			StartSoundEventFromPosition("Hero_ArcWarden.MagneticField.Cast",point)
		end
	end
end