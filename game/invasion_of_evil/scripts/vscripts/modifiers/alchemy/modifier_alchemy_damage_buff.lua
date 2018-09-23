
if modifier_alchemy_damage_buff == nil then
    modifier_alchemy_damage_buff = class({})
end

function modifier_alchemy_damage_buff:IsHidden()
    return false
end

function modifier_alchemy_damage_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_damage_buff"
end

function modifier_alchemy_damage_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_damage_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_alchemy_damage_buff:GetModifierPreAttack_BonusDamage()
    return self.damageBonus
end

function modifier_alchemy_damage_buff:OnCreated()
    self.damageBonus = 22
end



