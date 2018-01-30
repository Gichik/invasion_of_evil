
if modifier_berserk_heroism == nil then
    modifier_berserk_heroism = class({})
end

function modifier_berserk_heroism:IsHidden()
	return true
end

function modifier_berserk_heroism:RemoveOnDeath()
	return true
end

function modifier_berserk_heroism:GetTexture()
    return "custom_folder/berserk_heroism"
end

function modifier_berserk_heroism:OnCreated()
	self.auraDuration = 0.3
end

function modifier_berserk_heroism:IsAura()
    return true
end

function modifier_berserk_heroism:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_berserk_heroism:GetModifierAura()
    return "modifier_berserk_heroism_mark"
end

function modifier_berserk_heroism:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_berserk_heroism:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_berserk_heroism:GetAuraDuration()
    return self.auraDuration
end

--------------------------------------------------------------------------------

modifier_berserk_heroism_mark = class({})

function modifier_berserk_heroism_mark:IsHidden()
    return true
end

function modifier_berserk_heroism_mark:RemoveOnDeath()
    return true
end

function modifier_berserk_heroism_mark:OnCreated()
	if IsServer() then
		self.auraRadius = self:GetCaster():FindAbilityByName("berserk_heroism"):GetCastRange()
	end
end

function modifier_berserk_heroism_mark:OnDestroy()
	if IsServer() then
		local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent(), self.auraRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			
		if units then	
			for i = 1, #units do	
				local modifier = units[i]:FindModifierByName("modifier_berserk_heroism")
				if modifier then
					units[i]:AddNewModifier(units[i], modifier:GetAbility(), "modifier_berserk_heroism_buff", {duration = 10})
				end		
			end
		end		
	end
end

--------------------------------------------------------------------------------


modifier_berserk_heroism_buff = class({})


function modifier_berserk_heroism_buff:IsHidden()
	return false
end

function modifier_berserk_heroism_buff:GetTexture()
    return "custom_folder/berserk_heroism"
end

function modifier_berserk_heroism_buff:RemoveOnDeath()
	return true
end

function modifier_berserk_heroism_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_berserk_heroism_buff:GetModifierConstantHealthRegen()	
	return self:GetStackCount()*self.hp_regen or 0
end

function modifier_berserk_heroism_buff:OnCreated(data)
	self.hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
	self:SetStackCount(self:GetAbility():GetLevel())
end

function modifier_berserk_heroism_buff:OnRefresh()
	self.hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
	self:SetStackCount(self:GetAbility():GetLevel())
end
