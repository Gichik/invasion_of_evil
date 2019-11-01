
if modifier_madman_imposing == nil then
    modifier_madman_imposing = class({})
end

function modifier_madman_imposing:IsHidden()
	return true
end

function modifier_madman_imposing:GetTexture()
    return "earthshaker_enchant_totem"
end

function modifier_madman_imposing:RemoveOnDeath()
	return false
end

function modifier_madman_imposing:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_madman_imposing:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str") or 0
end

function modifier_madman_imposing:GetModifierAttackSpeedBonus_Constant()
	return -self:GetAbility():GetSpecialValueFor("reduce_attack_speed") or 0
end