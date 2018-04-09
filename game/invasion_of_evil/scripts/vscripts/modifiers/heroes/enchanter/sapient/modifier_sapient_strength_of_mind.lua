
if modifier_sapient_strength_of_mind == nil then
    modifier_sapient_strength_of_mind = class({})
end

function modifier_sapient_strength_of_mind:IsHidden()
	return true
end

function modifier_sapient_strength_of_mind:GetTexture()
    return "chen_hand_of_god"
end

function modifier_sapient_strength_of_mind:RemoveOnDeath()
	return false
end

function modifier_sapient_strength_of_mind:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXTRA_MANA_BONUS
    }
    return funcs
end

function modifier_sapient_strength_of_mind:GetModifierExtraManaBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_mana") or 0
end

