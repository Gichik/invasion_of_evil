
if modifier_elementalist_magic_of_energy == nil then
    modifier_elementalist_magic_of_energy = class({})
end

function modifier_elementalist_magic_of_energy:IsHidden()
	return true
end

function modifier_elementalist_magic_of_energy:GetTexture()
    return "nyx_assassin_mana_burn"
end

function modifier_elementalist_magic_of_energy:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_energy:IsPurgable()
    return false
end

function modifier_elementalist_magic_of_energy:IsPurgeException()
    return false
end

function modifier_elementalist_magic_of_energy:DeclareFunctions()
    return nil
end

function modifier_elementalist_magic_of_energy:IsAura()
    return true
end

function modifier_elementalist_magic_of_energy:GetModifierAura()
    return "modifier_elementalist_magic_of_energy_buff"
end


function modifier_elementalist_magic_of_energy:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_elementalist_magic_of_energy:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_elementalist_magic_of_energy:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_elementalist_magic_of_energy:GetAuraEntityReject(target)
    return false
end

function modifier_elementalist_magic_of_energy:GetAuraDuration()
    return 0.5
end


--------------------------------------------------------------------------------

modifier_elementalist_magic_of_energy_buff = class({})

function modifier_elementalist_magic_of_energy_buff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_energy_buff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_energy_buff:GetTexture()
    return "nyx_assassin_mana_burn"
end

function modifier_elementalist_magic_of_energy_buff:GetEffectName()
    --return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
    return nil
end

function modifier_elementalist_magic_of_energy_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_elementalist_magic_of_energy_buff:OnAttackLanded(data)
    if IsServer() then
        if data.attacker == self:GetParent() then
            data.attacker:GiveMana(self.mana_recovery)
        end
    end
end


function modifier_elementalist_magic_of_energy_buff:OnCreated()    
    self.mana_recovery = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.mana_recovery = self.ability:GetSpecialValueFor("mana_recovery")
    end
end

function modifier_elementalist_magic_of_energy_buff:OnRefresh()    
    self.mana_recovery = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.mana_recovery = self.ability:GetSpecialValueFor("mana_recovery")
    end
end
