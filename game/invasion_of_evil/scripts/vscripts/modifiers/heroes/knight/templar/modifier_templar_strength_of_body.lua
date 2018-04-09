
if modifier_templar_strength_of_body == nil then
    modifier_templar_strength_of_body = class({})
end

function modifier_templar_strength_of_body:IsHidden()
	return true
end

function modifier_templar_strength_of_body:GetTexture()
    return "earth_spirit_petrify"
end

function modifier_templar_strength_of_body:RemoveOnDeath()
	return false
end

function modifier_templar_strength_of_body:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
    }
    return funcs
end

function modifier_templar_strength_of_body:GetModifierExtraHealthBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_health")*self:GetAbility():GetLevel() or 0
end



