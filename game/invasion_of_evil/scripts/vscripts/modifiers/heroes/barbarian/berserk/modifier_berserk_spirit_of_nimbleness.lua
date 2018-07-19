if modifier_berserk_spirit_of_nimbleness == nil then
    modifier_berserk_spirit_of_nimbleness = class({})
end

function modifier_berserk_spirit_of_nimbleness:GetTexture()
    return  "custom_folder/berserk_runner"
end

function modifier_berserk_spirit_of_nimbleness:IsHidden()
	return true
end

function modifier_berserk_spirit_of_nimbleness:RemoveOnDeath()
	return false
end

function modifier_berserk_spirit_of_nimbleness:IsAura()
    return true
end

function modifier_berserk_spirit_of_nimbleness:GetModifierAura()
    return "modifier_berserk_spirit_of_nimbleness_buff"
end

function modifier_berserk_spirit_of_nimbleness:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_berserk_spirit_of_nimbleness:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_berserk_spirit_of_nimbleness:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_berserk_spirit_of_nimbleness:GetAuraDuration()
    return self.auraDuration
end

function modifier_berserk_spirit_of_nimbleness:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_berserk_spirit_of_nimbleness_buff = class({})

function modifier_berserk_spirit_of_nimbleness_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_berserk_spirit_of_nimbleness_buff:GetModifierMoveSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_move_speed") or 0
end

function modifier_berserk_spirit_of_nimbleness_buff:GetTexture()
   return  "custom_folder/berserk_runner"
end

function modifier_berserk_spirit_of_nimbleness_buff:IsHidden()
    return false
end

function modifier_berserk_spirit_of_nimbleness_buff:RemoveOnDeath()
    return true
end
