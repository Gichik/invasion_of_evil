
if modifier_elementalist_magic_of_air == nil then
    modifier_elementalist_magic_of_air = class({})
end

function modifier_elementalist_magic_of_air:IsHidden()
	return true
end

function modifier_elementalist_magic_of_air:GetTexture()
    return "skywrath_mage_mystic_flare"
end

function modifier_elementalist_magic_of_air:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_air:IsPurgable()
    return false
end

function modifier_elementalist_magic_of_air:IsPurgeException()
    return false
end

function modifier_elementalist_magic_of_air:DeclareFunctions()
    return nil
end

function modifier_elementalist_magic_of_air:IsAura()
    return true
end

function modifier_elementalist_magic_of_air:GetModifierAura()
    return "modifier_elementalist_magic_of_air_buff"
end


function modifier_elementalist_magic_of_air:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_elementalist_magic_of_air:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_elementalist_magic_of_air:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_elementalist_magic_of_air:GetAuraEntityReject(target)
    return false
end

function modifier_elementalist_magic_of_air:GetAuraDuration()
    return 0.5
end


--------------------------------------------------------------------------------

modifier_elementalist_magic_of_air_buff = class({})

function modifier_elementalist_magic_of_air_buff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_air_buff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_air_buff:GetTexture()
    return "skywrath_mage_mystic_flare"
end

function modifier_elementalist_magic_of_air_buff:GetEffectName()
    --return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
    return nil
end

function modifier_elementalist_magic_of_air_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_elementalist_magic_of_air_buff:GetModifierPreAttack_BonusDamage()     
    return self.bonus_dmg
end


function modifier_elementalist_magic_of_air_buff:OnCreated()    
    self.bonus_dmg = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.bonus_dmg = self.ability:GetSpecialValueFor("bonus_dmg")
    end
end

function modifier_elementalist_magic_of_air_buff:OnRefresh()    
    self.bonus_dmg = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.bonus_dmg = self.ability:GetSpecialValueFor("bonus_dmg")
    end
end