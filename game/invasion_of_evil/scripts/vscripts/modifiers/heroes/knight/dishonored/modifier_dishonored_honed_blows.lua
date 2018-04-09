
if modifier_dishonored_honed_blows == nil then
    modifier_dishonored_honed_blows = class({})
end

function modifier_dishonored_honed_blows:IsHidden()
	return true
end

function modifier_dishonored_honed_blows:GetTexture()
    return "magnataur_empower"
end

function modifier_dishonored_honed_blows:RemoveOnDeath()
	return false
end

function modifier_dishonored_honed_blows:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_dishonored_honed_blows:GetModifierPreAttack_BonusDamage()		
	return self:GetAbility():GetSpecialValueFor("bonus_dmg") or 0
end



