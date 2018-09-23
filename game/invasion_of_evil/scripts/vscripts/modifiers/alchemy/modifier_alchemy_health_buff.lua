
if modifier_alchemy_health_buff == nil then
    modifier_alchemy_health_buff = class({})
end

function modifier_alchemy_health_buff:IsHidden()
    return false
end

function modifier_alchemy_health_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_health_buff"
end

function modifier_alchemy_health_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_health_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
    }
    return funcs
end

function modifier_alchemy_health_buff:GetModifierExtraHealthBonus() 
    return self.healthBonus
end

function modifier_alchemy_health_buff:OnCreated()
    self.healthBonus = 600
end



