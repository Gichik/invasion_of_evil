
if modifier_templar_heavy_armor == nil then
    modifier_templar_heavy_armor = class({})
end

function modifier_templar_heavy_armor:IsHidden()
	return true
end

function modifier_templar_heavy_armor:GetTexture()
    return "lich_frost_armor"
end

function modifier_templar_heavy_armor:RemoveOnDeath()
	return true
end

function modifier_templar_heavy_armor:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_templar_heavy_armor:GetModifierPhysicalArmorBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_armor")*self:GetAbility():GetLevel() or 0
end


