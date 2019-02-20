
if modifier_enchantment_aura_hp_regen== nil then
    modifier_enchantment_aura_hp_regen= class({})
end

function modifier_enchantment_aura_hp_regen:IsHidden()
	return true
end

function modifier_enchantment_aura_hp_regen:RemoveOnDeath()
	return false
end

function modifier_enchantment_aura_hp_regen:GetTexture()
    return "earth_spirit_petrify"
end

function modifier_enchantment_aura_hp_regen:OnCreated()
	self.auraDuration = 0.3
end

function modifier_enchantment_aura_hp_regen:IsAura()
    return true
end

function modifier_enchantment_aura_hp_regen:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_enchantment_aura_hp_regen:GetModifierAura()
    return "modifier_enchantment_hp_regen_buff"
end

function modifier_enchantment_aura_hp_regen:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_enchantment_aura_hp_regen:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_enchantment_aura_hp_regen:GetAuraDuration()
    return self.auraDuration
end


--------------------------------------------------------------------------------


modifier_enchantment_hp_regen_buff = class({})


function modifier_enchantment_hp_regen_buff:IsHidden()
	return false
end

function modifier_enchantment_hp_regen_buff:GetTexture()
    return "earth_spirit_petrify"
end

function modifier_enchantment_hp_regen_buff:RemoveOnDeath()
	return true
end

function modifier_enchantment_hp_regen_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_enchantment_hp_regen_buff:GetModifierConstantHealthRegen()	
	return self.hp_regen or 0
end

function modifier_enchantment_hp_regen_buff:OnCreated(data)
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_enchantment_hp_regen_buff:OnRefresh()
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end
