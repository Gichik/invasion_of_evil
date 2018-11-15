
if modifier_summoner_natural_density == nil then
    modifier_summoner_natural_density = class({})
end

function modifier_summoner_natural_density:IsHidden()
    if self:GetAbility() then   
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return false
            end
        end
    end
	return true
end

function modifier_summoner_natural_density:GetTexture()
    return "custom_folder/natural_density"
end

function modifier_summoner_natural_density:RemoveOnDeath()
	return true
end

function modifier_summoner_natural_density:IsPurgable()
    return false
end

function modifier_summoner_natural_density:IsPurgeException()
    return false
end

function modifier_summoner_natural_density:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_summoner_natural_density:GetModifierMagicalResistanceBonus()	
    if self:GetAbility() then	
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return self:GetAbility():GetSpecialValueFor("bonus_resist")
            end
        end
    end
    return 0
end

function modifier_summoner_natural_density:GetModifierPhysicalArmorBonus()	
    if self:GetAbility() then   
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return self:GetAbility():GetSpecialValueFor("bonus_armor")
            end
        end
    end
    return 0
end

