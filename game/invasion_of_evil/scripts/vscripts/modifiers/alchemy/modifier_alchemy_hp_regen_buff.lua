
if modifier_alchemy_hp_regen_buff == nil then
    modifier_alchemy_hp_regen_buff = class({})
end

function modifier_alchemy_hp_regen_buff:IsHidden()
	return false
end

function modifier_alchemy_hp_regen_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_hp_regen_buff"
end

function modifier_alchemy_hp_regen_buff:RemoveOnDeath()
	return true
end

function modifier_alchemy_hp_regen_buff:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_alchemy_hp_regen_buff:GetModifierConstantHealthRegen()
    return self.hpRegenBonus
end

function modifier_alchemy_hp_regen_buff:OnCreated()
	self.hpRegenBonus = 9
end


