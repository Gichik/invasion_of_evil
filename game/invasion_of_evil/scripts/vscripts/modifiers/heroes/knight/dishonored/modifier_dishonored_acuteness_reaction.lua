
if modifier_dishonored_acuteness_reaction == nil then
    modifier_dishonored_acuteness_reaction = class({})
end

function modifier_dishonored_acuteness_reaction:IsHidden()
	return true
end

function modifier_dishonored_acuteness_reaction:GetTexture()
    return "disruptor_glimpse"
end

function modifier_dishonored_acuteness_reaction:RemoveOnDeath()
	return false
end

function modifier_dishonored_acuteness_reaction:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
    }
    return funcs
end

function modifier_dishonored_acuteness_reaction:GetModifierEvasion_Constant()	
	return self:GetAbility():GetSpecialValueFor("evasion_chance") or 0
end


