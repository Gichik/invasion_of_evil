
if modifier_exile_severity == nil then
    modifier_exile_severity = class({})
end

function modifier_exile_severity:IsHidden()
	return true
end

function modifier_exile_severity:GetTexture()
    return "custom_folder/exile_severity"
end

function modifier_exile_severity:RemoveOnDeath()
	return false
end

function modifier_exile_severity:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_exile_severity:GetModifierPreAttack_BonusDamage()	
	return self:GetAbility():GetSpecialValueFor("bonus_dmg") or 0
end

