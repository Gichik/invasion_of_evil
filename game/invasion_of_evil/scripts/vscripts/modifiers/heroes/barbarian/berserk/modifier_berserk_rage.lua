
if modifier_berserk_rage == nil then
    modifier_berserk_rage = class({})
end

function modifier_berserk_rage:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
    return funcs
end

function modifier_berserk_rage:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_berserk_rage:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_berserk_rage:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_berserk_rage:GetModifierConstantHealthRegen()
    return self:GetAbility():GetSpecialValueFor("rage_bonus_hp_regen")
end

function modifier_berserk_rage:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("rage_bonus_as")
end

function modifier_berserk_rage:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("rage_bonus_str")
end

function modifier_berserk_rage:GetTexture()
    return "axe_berserkers_call"
end

function modifier_berserk_rage:GetEffectName()
    return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_berserk_rage:IsHidden()
    return false
end

function modifier_berserk_rage:RemoveOnDeath()
    return false
end


function modifier_berserk_rage:OnCreated(data)
    if IsServer() then
    	self:GetParent():EmitSound("Hero_Axe.BerserkersCall.Start")
    end
end
