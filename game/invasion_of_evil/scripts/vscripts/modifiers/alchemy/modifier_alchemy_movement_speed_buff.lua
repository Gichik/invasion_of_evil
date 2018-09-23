
if modifier_alchemy_movement_speed_buff == nil then
    modifier_alchemy_movement_speed_buff = class({})
end

function modifier_alchemy_movement_speed_buff:IsHidden()
    return false
end

function modifier_alchemy_movement_speed_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_movement_speed_buff"
end

function modifier_alchemy_movement_speed_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_movement_speed_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_alchemy_movement_speed_buff:GetModifierMoveSpeedBonus_Constant()
    return self.moveSpeedBonus
end

function modifier_alchemy_movement_speed_buff:OnCreated()
    self.moveSpeedBonus = 100
end



