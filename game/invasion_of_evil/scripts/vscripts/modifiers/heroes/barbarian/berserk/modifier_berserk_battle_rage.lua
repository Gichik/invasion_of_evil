
if modifier_berserk_battle_rage == nil then
    modifier_berserk_battle_rage = class({})
end

function modifier_berserk_battle_rage:IsHidden()
	return true
end

function modifier_berserk_battle_rage:RemoveOnDeath()
	return false
end

function modifier_berserk_battle_rage:GetTexture()
    return "custom_folder/berserk_battle_rage"
end

function modifier_berserk_battle_rage:OnCreated()
	self.auraDuration = 0.3
end

function modifier_berserk_battle_rage:IsAura()
    return true
end

function modifier_berserk_battle_rage:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_berserk_battle_rage:GetModifierAura()
    return "modifier_berserk_battle_rage_mark"
end

function modifier_berserk_battle_rage:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_berserk_battle_rage:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_berserk_battle_rage:GetAuraDuration()
    return self.auraDuration
end

--------------------------------------------------------------------------------

modifier_berserk_battle_rage_mark = class({})

function modifier_berserk_battle_rage_mark:IsHidden()
    return true
end

function modifier_berserk_battle_rage_mark:RemoveOnDeath()
    return true
end

function modifier_berserk_battle_rage_mark:OnCreated(data)
	if IsServer() then
		self.auraRadius = self:GetCaster():FindAbilityByName("berserk_battle_rage"):GetCastRange()
	end
end

function modifier_berserk_battle_rage_mark:OnDestroy()
	if IsServer() then
		local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent(), self.auraRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			
		if units then	
			for i = 1, #units do	
				local modifier = units[i]:FindModifierByName("modifier_berserk_battle_rage")
				if modifier then
					units[i]:AddNewModifier(units[i], modifier:GetAbility(), "modifier_berserk_battle_rage_buff", {duration = 10})
				end		
			end
		end		
	end
end

--------------------------------------------------------------------------------


modifier_berserk_battle_rage_buff = class({})


function modifier_berserk_battle_rage_buff:IsHidden()
	return false
end

function modifier_berserk_battle_rage_buff:GetTexture()
    return "custom_folder/berserk_battle_rage"
end

function modifier_berserk_battle_rage_buff:RemoveOnDeath()
	return true
end

function modifier_berserk_battle_rage_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_berserk_battle_rage_buff:GetModifierPreAttack_BonusDamage()	
	return self:GetStackCount()*self.bonus_damage or 0
end

function modifier_berserk_battle_rage_buff:OnCreated(data)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self:SetStackCount(self:GetAbility():GetLevel())
end

function modifier_berserk_battle_rage_buff:OnRefresh()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self:SetStackCount(self:GetAbility():GetLevel())
end
