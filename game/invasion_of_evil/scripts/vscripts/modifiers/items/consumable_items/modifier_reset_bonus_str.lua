
if modifier_reset_bonus_str == nil then
    modifier_reset_bonus_str = class({})
end

function modifier_reset_bonus_str:IsHidden()
	return false
end

function modifier_reset_bonus_str:GetTexture()
    return "custom_folder/modifier_reset_bonus_str"
end

function modifier_reset_bonus_str:RemoveOnDeath()
	return false
end

function modifier_reset_bonus_str:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
    return funcs
end

function modifier_reset_bonus_str:GetModifierBonusStats_Strength()
	return self:GetStackCount()*self.bonus_str or 0
end

function modifier_reset_bonus_str:OnCreated()
	self.hParent = self:GetParent()
	self.bonus_str = 20
	if self.hParent then
		if self.hParent.numResetBonusStr then
			self:SetStackCount(self.hParent.numResetBonusStr)
		end
	end
end