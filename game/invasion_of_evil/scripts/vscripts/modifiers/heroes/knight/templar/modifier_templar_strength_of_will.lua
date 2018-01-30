
if modifier_templar_strength_of_will == nil then
    modifier_templar_strength_of_will = class({})
end

function modifier_templar_strength_of_will:IsHidden()
	return true
end

function modifier_templar_strength_of_will:GetTexture()
    return "custom_folder/templar_strength_of_will"
end

function modifier_templar_strength_of_will:RemoveOnDeath()
	return true
end

function modifier_templar_strength_of_will:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_templar_strength_of_will:GetModifierMagicalResistanceBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist") or 0
end

