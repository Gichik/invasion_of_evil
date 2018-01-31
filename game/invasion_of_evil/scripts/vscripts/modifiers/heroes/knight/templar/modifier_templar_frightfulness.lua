
if modifier_templar_frightfulness == nil then
    modifier_templar_frightfulness = class({})
end

function modifier_templar_frightfulness:GetTexture()
    return "dragon_knight_dragon_blood"
end

function modifier_templar_frightfulness:IsHidden()
	return true
end

function modifier_templar_frightfulness:RemoveOnDeath()
	return true
end

function modifier_templar_frightfulness:IsAura()
    return true
end

function modifier_templar_frightfulness:GetModifierAura()
    return "modifier_templar_frightfulness_debuff"
end

function modifier_templar_frightfulness:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_templar_frightfulness:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_templar_frightfulness:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_templar_frightfulness:GetAuraDuration()
    return self.auraDuration
end

function modifier_templar_frightfulness:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_templar_frightfulness_debuff = class({})

function modifier_templar_frightfulness_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_templar_frightfulness_debuff:GetModifierPhysicalArmorBonus()	
	return -self:GetStackCount() or 0
end

function modifier_templar_frightfulness_debuff:GetTexture()
    return "dragon_knight_dragon_blood"
end

function modifier_templar_frightfulness_debuff:IsHidden()
    return true
end

function modifier_templar_frightfulness_debuff:RemoveOnDeath()
    return true
end

function modifier_templar_frightfulness_debuff:OnCreated()
    if IsServer() then
        self.reduce_armor = self:GetCaster():FindAbilityByName("templar_frightfulness"):GetSpecialValueFor("reduce_armor") or 0
        self:SetStackCount(self.reduce_armor)
    end
end
