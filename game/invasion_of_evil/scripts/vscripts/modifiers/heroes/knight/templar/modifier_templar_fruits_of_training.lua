
if modifier_templar_fruits_of_training == nil then
    modifier_templar_fruits_of_training = class({})
end

function modifier_templar_fruits_of_training:IsHidden()
	return true
end

function modifier_templar_fruits_of_training:GetTexture()
    return "magnataur_empower"
end

function modifier_templar_fruits_of_training:RemoveOnDeath()
	return false
end

function modifier_templar_fruits_of_training:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_templar_fruits_of_training:GetModifierPreAttack_BonusDamage()		
	return self:GetAbility():GetSpecialValueFor("bonus_dmg")*self:GetAbility():GetLevel() or 0
end



