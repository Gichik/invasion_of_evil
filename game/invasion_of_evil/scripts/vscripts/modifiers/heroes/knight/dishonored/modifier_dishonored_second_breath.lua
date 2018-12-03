
if modifier_dishonored_second_breath == nil then
    modifier_dishonored_second_breath = class({})
end

function modifier_dishonored_second_breath:IsHidden()
	return true
end

function modifier_dishonored_second_breath:GetTexture()
    return "custom_folder/dishonored_second_breath"
end

function modifier_dishonored_second_breath:RemoveOnDeath()
	return false
end

function modifier_dishonored_second_breath:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
    return funcs
end

function modifier_dishonored_second_breath:GetModifierBonusStats_Agility()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_agility") or 0
end

function modifier_dishonored_second_breath:OnCreated() 
	self.thresholdPerc = self:GetAbility():GetSpecialValueFor("threshold_perc") 
	if IsServer() then
		self:StartIntervalThink(0.3) 
	end
end

function modifier_dishonored_second_breath:OnIntervalThink()
	local stack = self:GetParent():GetMaxHealth()*self.thresholdPerc/100
	stack = (self:GetParent():GetMaxHealth() - self:GetParent():GetHealth())/stack
	self:SetStackCount(stack)
end