
if modifier_vampire_sower_of_horror == nil then
    modifier_vampire_sower_of_horror = class({})
end

function modifier_vampire_sower_of_horror:GetModifierAura()
    return "modifier_vampire_sower_of_horror_debuff"
end

function modifier_vampire_sower_of_horror:IsHidden()
	return true
end

function modifier_vampire_sower_of_horror:RemoveOnDeath()
	return true
end

function modifier_vampire_sower_of_horror:IsAura()
    return true
end

function modifier_vampire_sower_of_horror:IsPurgable()
    return false
end

function modifier_vampire_sower_of_horror:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_horror:GetAuraRadius()
    return self:GetAbility():GetCastRange() or 0
end

function modifier_vampire_sower_of_horror:GetTexture()
    return "night_stalker_crippling_fear"
end

function modifier_vampire_sower_of_horror:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_vampire_sower_of_horror:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_vampire_sower_of_horror:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
    --return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_vampire_sower_of_horror:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_vampire_sower_of_horror:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end


function modifier_vampire_sower_of_horror:GetAuraDuration()
    return self.auraDuration
end

function modifier_vampire_sower_of_horror:OnCreated()
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_vampire_sower_of_horror_debuff = class({})

function modifier_vampire_sower_of_horror_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end

function modifier_vampire_sower_of_horror_debuff:GetModifierMagicalResistanceBonus()
    if self:GetParent() then
	   return -1*self:GetAbility():GetSpecialValueFor("reduce_magic_resist") 
    else
        return 0
    end
end

function modifier_vampire_sower_of_horror_debuff:GetTexture()
    return "night_stalker_crippling_fear"
end

function modifier_vampire_sower_of_horror_debuff:IsHidden()
    return false
end

function modifier_vampire_sower_of_horror_debuff:IsDebuff()
    return true
end

function modifier_vampire_sower_of_horror_debuff:RemoveOnDeath()
    return true
end

function modifier_vampire_sower_of_horror_debuff:IsPurgable()
    return false
end

function modifier_vampire_sower_of_horror_debuff:IsPurgeException()
    return false
end

function modifier_vampire_sower_of_horror_debuff:GetEffectName()
    return "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle_soft.vpcf"
end
