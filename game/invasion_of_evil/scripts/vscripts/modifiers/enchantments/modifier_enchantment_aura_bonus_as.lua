
if modifier_enchantment_aura_bonus_as == nil then
    modifier_enchantment_aura_bonus_as = class({})
end

modifier_name = modifier_enchantment_aura_bonus_as


function modifier_name:IsHidden()
	return true
end

function modifier_name:RemoveOnDeath()
	return false
end

function modifier_name:GetTexture()
    return "juggernaut_omni_slash"
end

function modifier_name:OnCreated()
	self.auraDuration = 0.3
end

function modifier_name:IsAura()
    return true
end

function modifier_name:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_name:GetModifierAura()
    return "modifier_enchantment_bonus_as_buff"
end

function modifier_name:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_name:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_name:GetAuraDuration()
    return self.auraDuration
end


--------------------------------------------------------------------------------


modifier_enchantment_bonus_as_buff = class({})


modifier_name_buff = modifier_enchantment_bonus_as_buff

function modifier_name_buff:IsHidden()
	return false
end

function modifier_name_buff:GetTexture()
    return "juggernaut_omni_slash"
end

function modifier_name_buff:RemoveOnDeath()
	return true
end

function modifier_name_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_name_buff:GetModifierAttackSpeedBonus_Constant()	
	return self.bonus_as or 0
end

function modifier_name_buff:OnCreated(data)
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_speed")
end

function modifier_name_buff:OnRefresh()
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_speed")
end
