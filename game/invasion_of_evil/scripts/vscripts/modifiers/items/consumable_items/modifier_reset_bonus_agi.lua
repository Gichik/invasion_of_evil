
if modifier_reset_bonus_agi == nil then
    modifier_reset_bonus_agi = class({})
end

function modifier_reset_bonus_agi:IsHidden()
	return false
end

function modifier_reset_bonus_agi:GetTexture()
    return "custom_folder/modifier_reset_bonus_agi"
end

function modifier_reset_bonus_agi:RemoveOnDeath()
	return false
end

function modifier_reset_bonus_agi:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
    return funcs
end

function modifier_reset_bonus_agi:GetModifierBonusStats_Agility()
	return self:GetStackCount()*self.bonus_agi or 0
end

function modifier_reset_bonus_agi:OnCreated()
	self.hParent = self:GetParent()
	self.bonus_agi = 20
	if self.hParent then
		if self.hParent.numResetBonusAgi then
			self:SetStackCount(self.hParent.numResetBonusAgi)
		end
	end
end