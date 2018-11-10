
if modifier_vampire_sower_of_pain == nil then
    modifier_vampire_sower_of_pain = class({})
end

function modifier_vampire_sower_of_pain:GetModifierAura()
    return "modifier_vampire_sower_of_pain_debuff"
end

function modifier_vampire_sower_of_pain:IsHidden()
	return true
end

function modifier_vampire_sower_of_pain:RemoveOnDeath()
	return true
end

function modifier_vampire_sower_of_pain:IsAura()
    return true
end

function modifier_vampire_sower_of_pain:IsPurgable()
    return false
end

function modifier_vampire_sower_of_pain:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_pain:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_vampire_sower_of_pain:GetTexture()
    return "lich_dark_ritual"
end

function modifier_vampire_sower_of_pain:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_vampire_sower_of_pain:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_vampire_sower_of_pain:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
    --return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_vampire_sower_of_pain:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_vampire_sower_of_pain:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end


function modifier_vampire_sower_of_pain:GetAuraDuration()
    return self.auraDuration
end

function modifier_vampire_sower_of_pain:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_vampire_sower_of_pain_debuff = class({})

function modifier_vampire_sower_of_pain_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS }
end

function modifier_vampire_sower_of_pain_debuff:GetModifierExtraHealthBonus()
    if self:GetParent() then
	   return -1*self:GetParent():GetMaxHealth()*self:GetAbility():GetSpecialValueFor("reduce_health_proc")/100
    else
        return 0
    end
end

function modifier_vampire_sower_of_pain_debuff:GetTexture()
    return "lich_dark_ritual"
end

function modifier_vampire_sower_of_pain_debuff:IsHidden()
    return false
end

function modifier_vampire_sower_of_pain_debuff:IsDebuff()
    return true
end

function modifier_vampire_sower_of_pain_debuff:RemoveOnDeath()
    return true
end

function modifier_vampire_sower_of_pain_debuff:IsPurgable()
    return false
end

function modifier_vampire_sower_of_pain_debuff:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_pain_debuff:GetEffectName()
    return "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail_circle.vpcf"
end
