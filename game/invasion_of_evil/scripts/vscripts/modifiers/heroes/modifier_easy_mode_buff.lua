
if modifier_easy_mode_buff == nil then
    modifier_easy_mode_buff = class({})
end

function modifier_easy_mode_buff:IsHidden()
	return false
end

function modifier_easy_mode_buff:GetTexture()
    return "dazzle_shallow_grave"
end

function modifier_easy_mode_buff:RemoveOnDeath()
	return false
end

function modifier_easy_mode_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_easy_mode_buff:GetModifierMagicalResistanceBonus()	
	return 35
end

function modifier_easy_mode_buff:GetModifierPhysicalArmorBonus()	
	return 20
end
