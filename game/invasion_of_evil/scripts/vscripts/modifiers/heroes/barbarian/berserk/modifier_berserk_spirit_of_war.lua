if modifier_berserk_spirit_of_war == nil then
    modifier_berserk_spirit_of_war = class({})
end

function modifier_berserk_spirit_of_war:GetTexture()
    return  "custom_folder/berserk_spirit_of_war"
end

function modifier_berserk_spirit_of_war:IsHidden()
	return true
end

function modifier_berserk_spirit_of_war:RemoveOnDeath()
	return false
end

function modifier_berserk_spirit_of_war:IsAura()
    return true
end

function modifier_berserk_spirit_of_war:GetModifierAura()
    return "modifier_berserk_spirit_of_war_buff"
end

function modifier_berserk_spirit_of_war:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_berserk_spirit_of_war:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_berserk_spirit_of_war:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_berserk_spirit_of_war:GetAuraDuration()
    return self.auraDuration
end

function modifier_berserk_spirit_of_war:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_berserk_spirit_of_war_buff = class({})

function modifier_berserk_spirit_of_war_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_berserk_spirit_of_war_buff:GetModifierAttackSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

function modifier_berserk_spirit_of_war_buff:GetTexture()
   return  "custom_folder/berserk_spirit_of_war"
end

function modifier_berserk_spirit_of_war_buff:IsHidden()
    return false
end

function modifier_berserk_spirit_of_war_buff:RemoveOnDeath()
    return true
end
