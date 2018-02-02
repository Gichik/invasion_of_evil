
if modifier_sapient_concentration == nil then
    modifier_sapient_concentration = class({})
end

function modifier_sapient_concentration:IsHidden()
	return true
end

function modifier_sapient_concentration:GetTexture()
    return "invoker_ghost_walk"
end

function modifier_sapient_concentration:RemoveOnDeath()
	return true
end

function modifier_sapient_concentration:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_sapient_concentration:GetModifierConstantManaRegen()
	if self:GetAbility() then	
		return self:GetAbility():GetSpecialValueFor("bonus_mana_regen") or 0
	end
	return 0
end