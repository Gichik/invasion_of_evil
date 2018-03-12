
if modifier_summoner_vampirism == nil then
    modifier_summoner_vampirism = class({})
end

function modifier_summoner_vampirism:IsHidden()
	return true
end

function modifier_summoner_vampirism:GetTexture()
    return "life_stealer_feast"
end

function modifier_summoner_vampirism:RemoveOnDeath()
	return true
end

function modifier_summoner_vampirism:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_summoner_vampirism:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then

			self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_perc")/100 or 0
			data.attacker:Heal(data.damage*self.lifesteal,data.attacker)
			ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.attacker)

			if data.attacker:GetOwner() then
				data.attacker:GetOwner():Heal(data.damage*self.lifesteal,data.attacker)
				ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.attacker:GetOwner())
			end

		end
	end
end