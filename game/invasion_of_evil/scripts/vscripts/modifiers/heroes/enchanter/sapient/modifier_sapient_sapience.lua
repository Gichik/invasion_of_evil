
if modifier_sapient_sapience == nil then
    modifier_sapient_sapience = class({})
end

function modifier_sapient_sapience:IsHidden()
	return true
end

function modifier_sapient_sapience:GetTexture()
    return "keeper_of_the_light_spirit_form"
end

function modifier_sapient_sapience:RemoveOnDeath()
	return false
end

function modifier_sapient_sapience:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
    return funcs
end

function modifier_sapient_sapience:GetModifierBonusStats_Intellect()	
	return self:GetAbility():GetSpecialValueFor("bonus_intellect") or 0
end