
if modifier_exile_alert == nil then
    modifier_exile_alert = class({})
end

function modifier_exile_alert:IsHidden()
	return true
end

function modifier_exile_alert:GetTexture()
    return "night_stalker_darkness"
end

function modifier_exile_alert:RemoveOnDeath()
	return false
end

function modifier_exile_alert:DeclareFunctions()
    return nil
end

function modifier_exile_alert:OnCreated()
	self.parent = self:GetParent()

	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_exile_alert:OnIntervalThink()
	if self:GetParent() then 
		if not GameRules:IsDaytime() then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_exile_alert_buff", {})
		else
			if self.parent:HasModifier("modifier_exile_alert_buff") then 
				self.parent:RemoveModifierByName("modifier_exile_alert_buff")
			end
		end
	end
end


-----------------------------------------------

modifier_exile_alert_buff = class({})

function modifier_exile_alert_buff:IsHidden()
	return false
end

function modifier_exile_alert_buff:GetTexture()
    return "night_stalker_darkness"
end

function modifier_exile_alert_buff:RemoveOnDeath()
	return false
end

function modifier_exile_alert_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_exile_alert_buff:GetModifierMagicalResistanceBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist") or 0
end

function modifier_exile_alert_buff:GetModifierConstantHealthRegen()	
	return self:GetAbility():GetSpecialValueFor("bonus_hp_regen") or 0
end