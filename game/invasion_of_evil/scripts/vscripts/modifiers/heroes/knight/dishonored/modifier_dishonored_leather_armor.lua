
if modifier_dishonored_leather_armor == nil then
    modifier_dishonored_leather_armor = class({})
end

function modifier_dishonored_leather_armor:IsHidden()
	return true
end

function modifier_dishonored_leather_armor:GetTexture()
    return "lich_frost_armor"
end

function modifier_dishonored_leather_armor:RemoveOnDeath()
	return false
end

function modifier_dishonored_leather_armor:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_dishonored_leather_armor:GetModifierPhysicalArmorBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_armor") or 0
end


