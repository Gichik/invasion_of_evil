
if modifier_dishonored_counterattack == nil then
    modifier_dishonored_counterattack = class({})
end

function modifier_dishonored_counterattack:IsHidden()
	return true
end

function modifier_dishonored_counterattack:GetTexture()
    return "custom_folder/dishonored_counterattack"
end

function modifier_dishonored_counterattack:RemoveOnDeath()
	return false
end

function modifier_dishonored_counterattack:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
    return funcs
end

function modifier_dishonored_counterattack:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			if self:GetAbility() then
				if RollPercentage(self:GetAbility():GetSpecialValueFor("counter_chance")) then
			        ApplyDamage({
			            victim = data.attacker,
			            attacker = self:GetParent(),
			            damage = self:GetParent():GetAttackDamage(),
			            damage_type = DAMAGE_TYPE_PURE,
			            ability = self:GetAbility()
			           })
			        ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())					
					EmitSoundOn("Hero_LegionCommander.Courage", self:GetParent())
				end
			end
		end
	end
end

