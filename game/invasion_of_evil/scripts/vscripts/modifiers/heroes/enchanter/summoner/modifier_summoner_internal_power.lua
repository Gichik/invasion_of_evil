
if modifier_summoner_internal_power == nil then
    modifier_summoner_internal_power = class({})
end

function modifier_summoner_internal_power:IsHidden()
    if self:GetAbility() then   
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return false
            end
        end
    end
	return true
end

function modifier_summoner_internal_power:GetTexture()
    return "visage_soul_assumption"
end

function modifier_summoner_internal_power:RemoveOnDeath()
	return true
end

function modifier_summoner_internal_power:IsPurgable()
    return false
end

function modifier_summoner_internal_power:IsPurgeException()
    return false
end

function modifier_summoner_internal_power:DeclareFunctions()
    return nil
end

function modifier_summoner_internal_power:IsAura()
    if self:GetAbility() then   
        if self:GetParent() then
            if self:GetParent().applyBuffs then
                return true
            end
        end
    end
    return false
end

function modifier_summoner_internal_power:GetModifierAura()
    return "modifier_summoner_internal_power_buff"
end


function modifier_summoner_internal_power:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("aura_radius")
end


function modifier_summoner_internal_power:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_summoner_internal_power:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_summoner_internal_power:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_summoner_internal_power:GetAuraEntityReject(target)
    if (target == self:GetParent()) then
        return true
    end
    return false
end

function modifier_summoner_internal_power:GetAuraDuration()
    return 0.5
end


--------------------------------------------------------------------------------

modifier_summoner_internal_power_buff = class({})

function modifier_summoner_internal_power_buff:IsHidden()
    return false
end

function modifier_summoner_internal_power_buff:RemoveOnDeath()
    return true
end

function modifier_summoner_internal_power_buff:GetTexture()
    return "custom_folder/internal_power"
end

function modifier_summoner_internal_power_buff:GetEffectName()
    return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
end

function modifier_summoner_internal_power_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_summoner_internal_power_buff:GetModifierMagicalResistanceBonus()  
    return self:GetAbility():GetSpecialValueFor("bonus_resist")
end

function modifier_summoner_internal_power_buff:GetModifierPhysicalArmorBonus()  
    return self:GetAbility():GetSpecialValueFor("bonus_armor")
end



