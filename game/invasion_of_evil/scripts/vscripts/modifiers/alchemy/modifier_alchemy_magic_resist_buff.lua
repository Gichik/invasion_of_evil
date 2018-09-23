
if modifier_alchemy_magic_resist_buff == nil then
    modifier_alchemy_magic_resist_buff = class({})
end

function modifier_alchemy_magic_resist_buff:IsHidden()
    return false
end

function modifier_alchemy_magic_resist_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_magic_resist_buff"
end

function modifier_alchemy_magic_resist_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_magic_resist_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_alchemy_magic_resist_buff:GetModifierMagicalResistanceBonus()
    return self.magicResBonus
end

function modifier_alchemy_magic_resist_buff:OnCreated()
    self.magicResBonus = 10
end



