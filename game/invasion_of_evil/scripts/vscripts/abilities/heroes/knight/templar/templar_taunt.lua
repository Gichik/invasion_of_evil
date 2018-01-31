
if templar_taunt == nil then
	templar_taunt = class({})
end

function templar_taunt:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function templar_taunt:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function templar_taunt:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function templar_taunt:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return UF_FAIL_CUSTOM
		end
	end

	return UF_SUCCESS
end

function templar_taunt:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return "#dota_hud_error_bad_taunt_target"
		end
	end

	return UF_SUCCESS
end

function templar_taunt:OnSpellStart()
   self:GetCursorTarget():SetAggroTarget(self:GetCaster())
end