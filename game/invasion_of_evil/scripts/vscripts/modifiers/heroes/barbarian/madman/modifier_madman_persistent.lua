
if modifier_madman_persistent == nil then
    modifier_madman_persistent = class({})
end

function modifier_madman_persistent:IsHidden()
	return true
end

function modifier_madman_persistent:GetTexture()
    return "life_stealer_rage"
end

function modifier_madman_persistent:RemoveOnDeath()
	return false
end

function modifier_madman_persistent:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_madman_persistent:GetModifierConstantHealthRegen()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("health_regen") or 0
end

function modifier_madman_persistent:OnCreated() 
	self.thresholdPerc = self:GetAbility():GetSpecialValueFor("threshold_perc") 
	if IsServer() then
		self:StartIntervalThink(0.3) 
	end
end

function modifier_madman_persistent:OnIntervalThink()
	local stack = self:GetParent():GetMaxHealth()*self.thresholdPerc/100
	stack = (self:GetParent():GetMaxHealth() - self:GetParent():GetHealth())/stack
	self:SetStackCount(stack)
end