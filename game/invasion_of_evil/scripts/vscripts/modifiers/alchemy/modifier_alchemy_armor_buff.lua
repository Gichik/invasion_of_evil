
if modifier_alchemy_armor_buff == nil then
    modifier_alchemy_armor_buff = class({})
end

function modifier_alchemy_armor_buff:IsHidden()
    return false
end

function modifier_alchemy_armor_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_armor_buff"
end

function modifier_alchemy_armor_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_armor_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_alchemy_armor_buff:GetModifierPhysicalArmorBonus()
    return self.physArmorBonus
end

function modifier_alchemy_armor_buff:OnCreated()
    self.physArmorBonus = 10
end



