
if modifier_exile_ardor == nil then
    modifier_exile_ardor = class({})
end

function modifier_exile_ardor:IsHidden()
	return false
end

function modifier_exile_ardor:GetTexture()
    return "phantom_lancer_juxtapose"
end

function modifier_exile_ardor:RemoveOnDeath()
	return false
end

function modifier_exile_ardor:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_exile_ardor:GetModifierMoveSpeedBonus_Constant()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_move_speed") or 0
end

function modifier_exile_ardor:GetModifierAttackSpeedBonus_Constant()	
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

function modifier_exile_ardor:OnCreated()
	if IsServer() then
		self.auraRadius = self:GetAbility():GetCastRange()
		self:StartIntervalThink(0.1)
	end
end

function modifier_exile_ardor:OnIntervalThink()
	if self:GetParent() then

		local parent = self:GetParent()
		local units = FindUnitsInRadius( 	parent:GetTeamNumber(), 
											parent:GetAbsOrigin(), 
											parent, self.auraRadius,
											DOTA_UNIT_TARGET_TEAM_ENEMY,
											DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 
											DOTA_UNIT_TARGET_FLAG_NONE, 
											0, 
											false )
			
		if units then	
			self:SetStackCount(#units)
		else
			self:SetStackCount(0)
		end	

	end
end


