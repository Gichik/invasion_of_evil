
if modifier_summoner_mammock == nil then
    modifier_summoner_mammock = class({})
end

function modifier_summoner_mammock:IsHidden()
    if self:GetCaster():IsRealHero() then
        return false
    else
        return true
    end
end

function modifier_summoner_mammock:GetTexture()
    return "tiny_grow"
end

function modifier_summoner_mammock:RemoveOnDeath()
	return true
end

function modifier_summoner_mammock:IsPurgable()
    return false
end

function modifier_summoner_mammock:IsPurgeException()
    return false
end

function modifier_summoner_mammock:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,    
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
    return funcs
end


function modifier_summoner_mammock:GetModifierExtraHealthBonus()
    if self:GetAbility() then
	   return self:GetAbility():GetSpecialValueFor("bonus_hp")
    end
    return 0    
end

function modifier_summoner_mammock:GetModifierConstantHealthRegen()	
    if self:GetAbility() then
	   return self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
    end
    return 0
end

function modifier_summoner_mammock:GetModifierModelScale()
    if self:GetAbility() then
	   return self:GetAbility():GetLevel()*7
    end
    return 0
end

function modifier_summoner_mammock:IsAura()
    return true
end

function modifier_summoner_mammock:GetAuraRadius()
    return 400
end

function modifier_summoner_mammock:GetModifierAura()
    return "modifier_summoner_mammock_debuff"
end

function modifier_summoner_mammock:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_summoner_mammock:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_summoner_mammock:GetAuraDuration()
    return 0.3
end

function modifier_summoner_mammock:OnCreated()
    self:GetCaster().applyBuffs = true
end


function modifier_summoner_mammock:OnDestroy()
    self:GetCaster().applyBuffs = false
end

--------------------------------------------------------------------------------

modifier_summoner_mammock_debuff = class({})

function modifier_summoner_mammock_debuff:IsHidden()
    return true
end

function modifier_summoner_mammock_debuff:RemoveOnDeath()
    return true
end

function modifier_summoner_mammock_debuff:IsPurgable()
    return false
end

function modifier_summoner_mammock_debuff:IsPurgeException()
    return false
end

function modifier_summoner_mammock_debuff:OnCreated()
    if IsServer() then
    	self:GetParent():SetAggroTarget(self:GetCaster())
    end
end

