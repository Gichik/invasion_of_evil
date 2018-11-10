
if modifier_vampire_night_power == nil then
    modifier_vampire_night_power = class({})
end

function modifier_vampire_night_power:IsHidden()
	return true
end

function modifier_vampire_night_power:GetTexture()
    return "luna_eclipse"
end

function modifier_vampire_night_power:RemoveOnDeath()
	return true
end

function modifier_vampire_night_power:DeclareFunctions()
    return nil
end

function modifier_vampire_night_power:IsPurgable()
    return false
end

function modifier_vampire_night_power:IsPurgeException()
    return false
end


function modifier_vampire_night_power:OnCreated()
	self.parent = self:GetParent()

	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_vampire_night_power:OnIntervalThink()
	if self:GetParent() then 
		if GameRules:IsDaytime() then
			self.parent:RemoveModifierByName("modifier_vampire_night_power_buff")
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_vampire_night_power_debuff", {})
		else
			self.parent:RemoveModifierByName("modifier_vampire_night_power_debuff")
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_vampire_night_power_buff", {})
		end
	end
end


-----------------------------------------------

modifier_vampire_night_power_debuff = class({})

function modifier_vampire_night_power_debuff:IsHidden()
	return true
end

function modifier_vampire_night_power_debuff:GetTexture()
    return "shadow_demon_demonic_purge"
end

function modifier_vampire_night_power_debuff:RemoveOnDeath()
	return false
end

function modifier_vampire_night_power_debuff:IsPurgable()
    return false
end

function modifier_vampire_night_power_debuff:IsPurgeException()
    return false
end

function modifier_vampire_night_power_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_vampire_night_power_debuff:GetModifierPreAttack_BonusDamage()	
	return -1*self:GetAbility():GetSpecialValueFor("bonus_damage")
end


-----------------------------------------------

modifier_vampire_night_power_buff = class({})

function modifier_vampire_night_power_buff:IsHidden()
	return true
end

function modifier_vampire_night_power_buff:GetTexture()
    return "shadow_demon_demonic_purge"
end

function modifier_vampire_night_power_buff:RemoveOnDeath()
	return false
end

function modifier_vampire_night_power_buff:IsPurgable()
    return false
end

function modifier_vampire_night_power_buff:IsPurgeException()
    return false
end

function modifier_vampire_night_power_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_vampire_night_power_buff:GetModifierPreAttack_BonusDamage()	
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_vampire_night_power_buff:GetModifierPreAttack_CriticalStrike()
	if RollPercentage(self:GetAbility():GetSpecialValueFor("crit_chance")) then
		return self:GetAbility():GetSpecialValueFor("crit_proc") or 0
	else
		return nil
	end
end




