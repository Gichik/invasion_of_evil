
if modifier_achievement_ghostbusters == nil then
    modifier_achievement_ghostbusters = class({})
end

function modifier_achievement_ghostbusters:IsHidden()
	return false
end

function modifier_achievement_ghostbusters:GetTexture()
    return "custom_folder/achievement"
end

function modifier_achievement_ghostbusters:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
    return funcs
end

function modifier_achievement_ghostbusters:GetModifierBonusStats_Strength()
	return self.strBonus
end

function modifier_achievement_ghostbusters:GetModifierBonusStats_Agility()
	return self.agiBonus
end

function modifier_achievement_ghostbusters:GetModifierBonusStats_Intellect()
	return self.eneBonus
end

function modifier_achievement_ghostbusters:OnCreated(data)
	if IsServer() then
		self.strBonus = 0
		self.agiBonus = 0
		self.eneBonus = 0

		local attribute = self:GetCaster():GetPrimaryAttribute() or 0
		
		if attribute == 0 then
			self.strBonus = 10
		end

		if attribute == 1 then
			self.agiBonus = 10
		end

		if attribute == 2 then
			self.eneBonus = 10
		end
	end
end
