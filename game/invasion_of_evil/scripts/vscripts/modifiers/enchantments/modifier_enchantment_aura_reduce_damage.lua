
if modifier_enchantment_aura_reduce_damage == nil then
    modifier_enchantment_aura_reduce_damage = class({})
end

modifier_name = modifier_enchantment_aura_reduce_damage


function modifier_name:IsHidden()
	return true
end

function modifier_name:RemoveOnDeath()
	return false
end

function modifier_name:GetTexture()
    return "centaur_return"
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
    return "modifier_enchantment_reduce_damage_buff"
end

function modifier_name:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_name:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_name:GetAuraDuration()
    return self.auraDuration
end


--------------------------------------------------------------------------------


modifier_enchantment_reduce_damage_buff = class({})


modifier_name_buff = modifier_enchantment_reduce_damage_buff

function modifier_name_buff:IsHidden()
	return false
end

function modifier_name_buff:IsDebuff()
    return true
end

function modifier_name_buff:GetTexture()
    return "centaur_return"
end

function modifier_name_buff:RemoveOnDeath()
	return true
end

function modifier_name_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_name_buff:GetModifierPreAttack_BonusDamage()	
	return -self.reduce_damage or 0
end

function modifier_name_buff:OnCreated(data)
	self.reduce_damage = self:GetAbility():GetSpecialValueFor("reduce_damage")
end

function modifier_name_buff:OnRefresh()
	self.reduce_damage = self:GetAbility():GetSpecialValueFor("reduce_damage")
end
