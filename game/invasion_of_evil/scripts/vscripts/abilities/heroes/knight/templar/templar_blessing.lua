
if templar_blessing == nil then
	templar_blessing = class({})
end

function templar_blessing:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function templar_blessing:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function templar_blessing:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function templar_blessing:GetAbilityDamageType()	
	return DAMAGE_TYPE_PURE
end

function templar_blessing:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			return UF_FAIL_CUSTOM
		end
	end

	return UF_SUCCESS
end

function templar_blessing:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			return "#dota_hud_error_bad_taunt_target"
		end
	end

	return UF_SUCCESS
end

function templar_blessing:OnSpellStart()
	if self:GetCaster() then
		hTarget = self:GetCursorTarget()

		if hTarget:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
			ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)					
			EmitSoundOn("Hero_Omniknight.Purification", hTarget)
			ApplyDamage({
	            victim = hTarget,
	            attacker = self:GetCaster(),
	            damage = self:GetSpecialValueFor("blessing_dmg"),
	            damage_type = self:GetAbilityDamageType(),
	            ability = self
	           })
		end

		if hTarget:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)					
			EmitSoundOn("Hero_Omniknight.Purification", hTarget)
			hTarget:Heal(self:GetSpecialValueFor("blessing_heal"), self:GetCaster())
		end

	end
end