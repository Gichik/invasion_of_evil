
if modifier_reset_bonus_int == nil then
    modifier_reset_bonus_int = class({})
end

function modifier_reset_bonus_int:IsHidden()
	return false
end

function modifier_reset_bonus_int:GetTexture()
    return "custom_folder/modifier_reset_bonus_int"
end

function modifier_reset_bonus_int:RemoveOnDeath()
	return false
end

function modifier_reset_bonus_int:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
    return funcs
end

function modifier_reset_bonus_int:GetModifierBonusStats_Intellect()
	return self:GetStackCount()*self.bonus_int or 0
end

function modifier_reset_bonus_int:OnCreated()
	self.hParent = self:GetParent()
	self.bonus_int = 20
	if self.hParent then
		if self.hParent.numResetBonusInt then
			self:SetStackCount(self.hParent.numResetBonusInt)
		end
	end
end