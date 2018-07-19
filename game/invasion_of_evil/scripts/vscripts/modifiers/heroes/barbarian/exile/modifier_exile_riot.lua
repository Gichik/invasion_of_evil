
if modifier_exile_riot == nil then
    modifier_exile_riot = class({})
end

function modifier_exile_riot:IsHidden()
	return true
end

function modifier_exile_riot:GetTexture()
    return "custom_folder/exile_riot"
end

function modifier_exile_riot:RemoveOnDeath()
	return false
end

function modifier_exile_riot:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_exile_riot:GetModifierAttackSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

