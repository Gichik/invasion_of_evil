
if modifier_dishonored_second_breath == nil then
    modifier_dishonored_second_breath = class({})
end

function modifier_dishonored_second_breath:IsHidden()
	return true
end

function modifier_dishonored_second_breath:GetTexture()
    return "custom_folder/dishonored_second_breath"
end

function modifier_dishonored_second_breath:DeclareFunctions()
    return nil
end

function modifier_dishonored_second_breath:RemoveOnDeath()
	return false
end

function modifier_dishonored_second_breath:OnCreated(data)
	self.parent = self:GetParent()
	self.think = 0.3
    if IsServer() then
		self:StartIntervalThink(self.think)
    end
end

function modifier_dishonored_second_breath:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetHealth() <= self.parent:GetMaxHealth()/2 then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_dishonored_second_breath_buff", {})
		else
			self.parent:RemoveModifierByName("modifier_dishonored_second_breath_buff")
		end
	end
end

---------------------------------------------------------------------

modifier_dishonored_second_breath_buff = class({})

function modifier_dishonored_second_breath_buff:IsHidden()
	return false
end

function modifier_dishonored_second_breath_buff:GetTexture()
    return "custom_folder/dishonored_second_breath"
end

function modifier_dishonored_second_breath_buff:RemoveOnDeath()
	return true
end

function modifier_dishonored_second_breath_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
    return funcs
end

function modifier_dishonored_second_breath_buff:GetModifierBonusStats_Agility()	
	return self:GetAbility():GetSpecialValueFor("bonus_agility") or 0
end
