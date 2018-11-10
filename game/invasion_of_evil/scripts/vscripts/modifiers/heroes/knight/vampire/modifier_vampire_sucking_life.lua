
if modifier_vampire_sucking_life == nil then
    modifier_vampire_sucking_life = class({})
end

function modifier_vampire_sucking_life:GetModifierAura()
    return "modifier_vampire_sucking_life_debuff"
end

function modifier_vampire_sucking_life:IsHidden()
    if self:GetStackCount() > 0 then
        return false
    else
        return true
    end
end

function modifier_vampire_sucking_life:RemoveOnDeath()
	return true
end

function modifier_vampire_sucking_life:IsAura()
    return true
end

function modifier_vampire_sucking_life:IsPurgable()
    return false
end

function modifier_vampire_sucking_life:IsPurgeException()
    return false
end

function modifier_vampire_sucking_life:GetAuraRadius()
    return self:GetAbility():GetCastRange() or 0
end

function modifier_vampire_sucking_life:GetTexture()
    return "death_prophet_spirit_siphon"
end

function modifier_vampire_sucking_life:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_vampire_sucking_life:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_vampire_sucking_life:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    --return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_vampire_sucking_life:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_vampire_sucking_life:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end

function modifier_vampire_sucking_life:DeclareFunctions()
    return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end

function modifier_vampire_sucking_life:GetModifierConstantHealthRegen()  
    return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_hp_regen") or 0
end

function modifier_vampire_sucking_life:GetAuraDuration()
    return self.auraDuration
end

function modifier_vampire_sucking_life:OnCreated()
    self.auraDuration = 0.3

    if IsServer() then
        self.auraRadius = self:GetAbility():GetCastRange()
        self:StartIntervalThink(0.5)
    end

end


function modifier_vampire_sucking_life:OnIntervalThink()
    if self:GetParent() then

        local parent = self:GetParent()
        local units = FindUnitsInRadius(    parent:GetTeamNumber(), 
                                            parent:GetAbsOrigin(), 
                                            parent, self.auraRadius,
                                            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                            DOTA_UNIT_TARGET_HERO, 
                                            DOTA_UNIT_TARGET_FLAG_NONE, 
                                            0, 
                                            false )
            
        if units then   
            self:SetStackCount(#units-1)
        else
            self:SetStackCount(0)
        end 

    end
end

--------------------------------------------------------------------------------

modifier_vampire_sucking_life_debuff = class({})

function modifier_vampire_sucking_life_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end

function modifier_vampire_sucking_life_debuff:GetModifierConstantHealthRegen()  
    if self:GetParent() then
        return -1*self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
    else
        return 0
    end    
end

function modifier_vampire_sucking_life_debuff:GetTexture()
    return "death_prophet_spirit_siphon"
end

function modifier_vampire_sucking_life_debuff:IsHidden()
    return false
end

function modifier_vampire_sucking_life_debuff:IsDebuff()
    return true
end

function modifier_vampire_sucking_life_debuff:RemoveOnDeath()
    return true
end

function modifier_vampire_sucking_life_debuff:IsPurgable()
    return false
end

function modifier_vampire_sucking_life_debuff:IsPurgeException()
    return false
end

function modifier_vampire_sucking_life_debuff:GetEffectName()
    return "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_debuff_echo_demo.vpcf"
end
