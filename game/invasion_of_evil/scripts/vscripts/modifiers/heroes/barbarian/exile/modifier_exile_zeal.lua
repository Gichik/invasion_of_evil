
if modifier_exile_zeal == nil then
    modifier_exile_zeal = class({})
end

function modifier_exile_zeal:IsHidden()
	return false
end

function modifier_exile_zeal:GetTexture()
    return "custom_folder/exile_zeal"
end

function modifier_exile_zeal:RemoveOnDeath()
	return false
end

function modifier_exile_zeal:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
    return funcs
end

function modifier_exile_zeal:GetModifierBonusStats_Strength()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_str") or 0
end

function modifier_exile_zeal:OnCreated()
	if IsServer() then
		self.auraRadius = self:GetAbility():GetCastRange()
		self:StartIntervalThink(0.5)
	end
end

function modifier_exile_zeal:OnIntervalThink()
	if self:GetParent() then

		local parent = self:GetParent()
		local units = FindUnitsInRadius( 	parent:GetTeamNumber(), 
											parent:GetAbsOrigin(), 
											parent, self.auraRadius,
											DOTA_UNIT_TARGET_TEAM_FRIENDLY,
											DOTA_UNIT_TARGET_HERO, 
											DOTA_UNIT_TARGET_FLAG_NONE, 
											0, 
											false )
			
		if units then	
			self:SetStackCount(#units-1)
		else
			self:SetStackCount(0)
		end	

	end
end


