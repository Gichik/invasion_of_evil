
if modifier_summoner_aesculapius == nil then
    modifier_summoner_aesculapius = class({})
end

function modifier_summoner_aesculapius:GetModifierAura()
    return "modifier_summoner_aesculapius_buff"
end

function modifier_summoner_aesculapius:IsHidden()
	return true
end

function modifier_summoner_aesculapius:RemoveOnDeath()
	return true
end

function modifier_summoner_aesculapius:IsAura()
    return true
end

function modifier_summoner_aesculapius:GetAuraRadius()
    return self.auraRadius
end

function modifier_summoner_aesculapius:GetTexture()
    return "puck_illusory_orb"
end

--function modifier_summoner_aesculapius:GetEffectName()
   --return "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf"
--end

function modifier_summoner_aesculapius:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_summoner_aesculapius:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_summoner_aesculapius:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_summoner_aesculapius:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end

function modifier_summoner_aesculapius:GetAuraDuration()
    return self.auraDuration
end

function modifier_summoner_aesculapius:OnCreated()
    self.auraRadius = self:GetAbility():GetSpecialValueFor("aura_radius") or 500
    self.auraDuration = 0.5
end


--------------------------------------------------------------------------------

modifier_summoner_aesculapius_buff = class({})

function modifier_summoner_aesculapius_buff:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_summoner_aesculapius_buff:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
    end
    return 0 
end

function modifier_summoner_aesculapius_buff:GetModifierConstantManaRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_mp_regen")
    end
    return 0         
end

function modifier_summoner_aesculapius_buff:GetTexture()
    return "puck_illusory_orb"
end

function modifier_summoner_aesculapius_buff:GetEffectName()
    return "particles/items_fx/healing_flask.vpcf"
end

function modifier_summoner_aesculapius_buff:IsHidden()
    return false
end

function modifier_summoner_aesculapius_buff:RemoveOnDeath()
    return true
end