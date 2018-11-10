
if modifier_vampire_sower_of_weakness == nil then
    modifier_vampire_sower_of_weakness = class({})
end

function modifier_vampire_sower_of_weakness:GetModifierAura()
    return "modifier_vampire_sower_of_weakness_debuff"
end

function modifier_vampire_sower_of_weakness:IsHidden()
	return true
end

function modifier_vampire_sower_of_weakness:RemoveOnDeath()
	return true
end

function modifier_vampire_sower_of_weakness:IsAura()
    return true
end

function modifier_vampire_sower_of_weakness:IsPurgable()
    return false
end

function modifier_vampire_sower_of_weakness:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_weakness:GetAuraRadius()
    return self:GetAbility():GetCastRange() or 0
end

function modifier_vampire_sower_of_weakness:GetTexture()
    return "spectre_desolate"
end

function modifier_vampire_sower_of_weakness:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_vampire_sower_of_weakness:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_vampire_sower_of_weakness:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
    --return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_vampire_sower_of_weakness:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_vampire_sower_of_weakness:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end


function modifier_vampire_sower_of_weakness:GetAuraDuration()
    return self.auraDuration
end

function modifier_vampire_sower_of_weakness:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_vampire_sower_of_weakness_debuff = class({})

function modifier_vampire_sower_of_weakness_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end

function modifier_vampire_sower_of_weakness_debuff:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent() then
        return -1*self:GetAbility():GetSpecialValueFor("reduce_attack_speed")
    else
        return 0
    end
end

function modifier_vampire_sower_of_weakness_debuff:GetTexture()
    return "spectre_desolate"
end

function modifier_vampire_sower_of_weakness_debuff:IsHidden()
    return false
end

function modifier_vampire_sower_of_weakness_debuff:IsDebuff()
    return true
end

function modifier_vampire_sower_of_weakness_debuff:RemoveOnDeath()
    return true
end

function modifier_vampire_sower_of_weakness_debuff:IsPurgable()
    return false
end

function modifier_vampire_sower_of_weakness_debuff:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_weakness_debuff:GetEffectName()
    return "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle.vpcf"
end
