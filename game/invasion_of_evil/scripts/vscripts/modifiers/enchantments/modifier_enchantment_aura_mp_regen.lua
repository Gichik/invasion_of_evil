
if modifier_enchantment_aura_mp_regen == nil then
    modifier_enchantment_aura_mp_regen = class({})
end

function modifier_enchantment_aura_mp_regen:IsHidden()
	return true
end

function modifier_enchantment_aura_mp_regen:RemoveOnDeath()
	return false
end

function modifier_enchantment_aura_mp_regen:GetTexture()
    return "crystal_maiden_brilliance_aura"
end

function modifier_enchantment_aura_mp_regen:OnCreated()
	self.auraDuration = 0.3
end

function modifier_enchantment_aura_mp_regen:IsAura()
    return true
end

function modifier_enchantment_aura_mp_regen:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_enchantment_aura_mp_regen:GetModifierAura()
    return "modifier_enchantment_mp_regen_buff"
end

function modifier_enchantment_aura_mp_regen:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_enchantment_aura_mp_regen:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_enchantment_aura_mp_regen:GetAuraDuration()
    return self.auraDuration
end


--------------------------------------------------------------------------------


modifier_enchantment_mp_regen_buff = class({})


function modifier_enchantment_mp_regen_buff:IsHidden()
	return false
end

function modifier_enchantment_mp_regen_buff:GetTexture()
    return "crystal_maiden_brilliance_aura"
end

function modifier_enchantment_mp_regen_buff:RemoveOnDeath()
	return true
end

function modifier_enchantment_mp_regen_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_enchantment_mp_regen_buff:GetModifierConstantManaRegen()	
	return self.mp_regen or 0
end

function modifier_enchantment_mp_regen_buff:OnCreated(data)
	self.mp_regen = self:GetAbility():GetSpecialValueFor("mp_regen")
end

function modifier_enchantment_mp_regen_buff:OnRefresh()
	self.mp_regen = self:GetAbility():GetSpecialValueFor("mp_regen")
end
