
if modifier_berserk_runner == nil then
    modifier_berserk_runner = class({})
end

function modifier_berserk_runner:IsHidden()
	return true
end

function modifier_berserk_runner:GetTexture()
    return "custom_folder/berserk_runner"
end

function modifier_berserk_runner:RemoveOnDeath()
	return false
end

function modifier_berserk_runner:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_berserk_runner:GetModifierMoveSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_move_speed")
end

