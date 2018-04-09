
if modifier_dishonored_sword_dance == nil then
    modifier_dishonored_sword_dance = class({})
end

function modifier_dishonored_sword_dance:IsHidden()
	return true
end

function modifier_dishonored_sword_dance:GetTexture()
    return "custom_folder/dishonored_sword_dance"
end

function modifier_dishonored_sword_dance:RemoveOnDeath()
	return false
end

function modifier_dishonored_sword_dance:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_dishonored_sword_dance:GetModifierAttackSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

