
if modifier_vampire_power_of_demon == nil then
    modifier_vampire_power_of_demon = class({})
end

function modifier_vampire_power_of_demon:IsHidden()
	if self:GetStackCount() > 0 then
		return false
	else
		return true
	end
end

function modifier_vampire_power_of_demon:GetTexture()
    return "necrolyte_heartstopper_aura"
end

function modifier_vampire_power_of_demon:IsPurgable()
    return false
end

function modifier_vampire_power_of_demon:IsPurgeException()
    return false
end

function modifier_vampire_power_of_demon:RemoveOnDeath()
	return false
end

function modifier_vampire_power_of_demon:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
    return funcs
end

function modifier_vampire_power_of_demon:GetModifierBonusStats_Agility()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("stats_bonus") or 0
end

function modifier_vampire_power_of_demon:GetModifierBonusStats_Strength()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("stats_bonus") or 0
end

function modifier_vampire_power_of_demon:GetModifierBonusStats_Intellect()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("stats_bonus") or 0
end
