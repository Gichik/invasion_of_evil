
if modifier_templar_nobleness == nil then
    modifier_templar_nobleness = class({})
end

function modifier_templar_nobleness:GetTexture()
    return "omniknight_degen_aura"
end

function modifier_templar_nobleness:IsHidden()
	return true
end

function modifier_templar_nobleness:RemoveOnDeath()
	return true
end

function modifier_templar_nobleness:IsAura()
    return true
end

function modifier_templar_nobleness:GetModifierAura()
    return "modifier_templar_nobleness_buff"
end

function modifier_templar_nobleness:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_templar_nobleness:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_templar_nobleness:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_templar_nobleness:GetAuraDuration()
    return self.auraDuration
end

function modifier_templar_nobleness:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_templar_nobleness_buff = class({})

function modifier_templar_nobleness_buff:DeclareFunctions()
    return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_templar_nobleness_buff:GetModifierPhysicalArmorBonus()	
	return self:GetStackCount() or 0
end

function modifier_templar_nobleness_buff:GetTexture()
    return "omniknight_degen_aura"
end

function modifier_templar_nobleness_buff:IsHidden()
    return true
end

function modifier_templar_nobleness_buff:RemoveOnDeath()
    return true
end

function modifier_templar_nobleness_buff:OnCreated()
    if IsServer() then
        self.bonus_armor = self:GetCaster():FindAbilityByName("templar_nobleness"):GetSpecialValueFor("bonus_armor") or 0
        self:SetStackCount(self.bonus_armor)
        if self:GetParent() ~= self:GetCaster() then
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetCaster():FindAbilityByName("templar_nobleness"), "modifier_templar_nobleness_lore", {})
        end
    end
end

function modifier_templar_nobleness_buff:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveModifierByName("modifier_templar_nobleness_lore")
    end
end
--------------------------------------------------------------------------------

modifier_templar_nobleness_lore = class({})

function modifier_templar_nobleness_lore:GetTexture()
    return "omniknight_degen_aura"
end

function modifier_templar_nobleness_lore:IsHidden()
    return false
end

function modifier_templar_nobleness_lore:RemoveOnDeath()
    return true
end