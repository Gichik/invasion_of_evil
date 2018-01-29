
if modifier_berserk_riot == nil then
    modifier_berserk_riot = class({})
end

function modifier_berserk_riot:IsHidden()
	return true
end

function modifier_berserk_riot:GetTexture()
    return "troll_warlord_whirling_axes_ranged"
end

function modifier_berserk_riot:RemoveOnDeath()
	return true
end

function modifier_berserk_riot:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_berserk_riot:GetModifierAttackSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

