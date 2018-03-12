
if modifier_summoner_predator == nil then
    modifier_summoner_predator = class({})
end

function modifier_summoner_predator:IsHidden()
	return true
end

function modifier_summoner_predator:GetTexture()
    return "nevermore_dark_lord"
end

function modifier_summoner_predator:RemoveOnDeath()
	return true
end

function modifier_summoner_predator:CanBeAddToMinions()
    return true
end

function modifier_summoner_predator:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_summoner_predator:GetModifierAttackSpeedBonus_Constant()
    if self:GetAbility() then
	   return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    end
    return 0 
end

function modifier_summoner_predator:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then	
	   return self:GetAbility():GetSpecialValueFor("bonus_damage")
    end
    return 0        
end



