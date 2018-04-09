
if modifier_sapient_cheerful_spirit == nil then
    modifier_sapient_cheerful_spirit = class({})
end

function modifier_sapient_cheerful_spirit:IsHidden()
	return true
end

function modifier_sapient_cheerful_spirit:GetTexture()
    return "witch_doctor_voodoo_restoration"
end

function modifier_sapient_cheerful_spirit:RemoveOnDeath()
	return false
end

function modifier_sapient_cheerful_spirit:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_sapient_cheerful_spirit:GetModifierAttackSpeedBonus_Constant()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
	end
	return 0
end

