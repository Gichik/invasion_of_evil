
if modifier_summoner_vampirism == nil then
    modifier_summoner_vampirism = class({})
end

function modifier_summoner_vampirism:IsHidden()
    if self:GetAbility() then   
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return false
            end
        end
    end
	return true
end

function modifier_summoner_vampirism:GetTexture()
    return "custom_folder/vampirism"
end

function modifier_summoner_vampirism:RemoveOnDeath()
	return true
end

function modifier_summoner_vampirism:IsPurgable()
    return false
end

function modifier_summoner_vampirism:IsPurgeException()
    return false
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

		    if self:GetAbility() then	
		        if self:GetParent() then
		            if self:GetParent().applyBuffs then
		                
						self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_perc")/100 or 0
						data.attacker:Heal(data.damage*self.lifesteal,data.attacker)
						ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.attacker)

						if not self:GetParent():IsRealHero() then
							if data.attacker:GetOwner() then
								data.attacker:GetOwner():Heal(data.damage*self.lifesteal,data.attacker)
								ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.attacker:GetOwner())
							end
						end

		            end
		        end
		    end

		end
	end
end