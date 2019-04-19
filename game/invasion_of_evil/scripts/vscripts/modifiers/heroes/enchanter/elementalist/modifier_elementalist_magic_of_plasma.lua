
if modifier_elementalist_magic_of_plasma == nil then
    modifier_elementalist_magic_of_plasma = class({})
end

function modifier_elementalist_magic_of_plasma:IsHidden()
	return true
end

function modifier_elementalist_magic_of_plasma:GetTexture()
    return "arc_warden_flux"
end

function modifier_elementalist_magic_of_plasma:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_plasma:IsPurgable()
    return false
end

function modifier_elementalist_magic_of_plasma:IsPurgeException()
    return false
end

function modifier_elementalist_magic_of_plasma:DeclareFunctions()
    return nil
end

function modifier_elementalist_magic_of_plasma:IsAura()
    return true
end

function modifier_elementalist_magic_of_plasma:GetModifierAura()
    return "modifier_elementalist_magic_of_plasma_buff"
end


function modifier_elementalist_magic_of_plasma:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_elementalist_magic_of_plasma:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_elementalist_magic_of_plasma:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_elementalist_magic_of_plasma:GetAuraEntityReject(target)
    return false
end

function modifier_elementalist_magic_of_plasma:GetAuraDuration()
    return 0.5
end


--------------------------------------------------------------------------------

modifier_elementalist_magic_of_plasma_buff = class({})

function modifier_elementalist_magic_of_plasma_buff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_plasma_buff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_plasma_buff:GetTexture()
    return "arc_warden_flux"
end

function modifier_elementalist_magic_of_plasma_buff:GetEffectName()
    --return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
    return nil
end

function modifier_elementalist_magic_of_plasma_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_elementalist_magic_of_plasma_buff:GetModifierMagicalResistanceBonus()  
    return self.bonus_resist
end

function modifier_elementalist_magic_of_plasma_buff:OnCreated()    
    self.bonus_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.bonus_resist = self.ability:GetSpecialValueFor("bonus_resist")
    end
end

function modifier_elementalist_magic_of_plasma_buff:OnRefresh()    
    self.bonus_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.bonus_resist = self.ability:GetSpecialValueFor("bonus_resist")
    end
end
