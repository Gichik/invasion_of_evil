if modifier_alchemy_evasion_buff == nil then
    modifier_alchemy_evasion_buff = class({})
end

function modifier_alchemy_evasion_buff:IsHidden()
	return false
end

function modifier_alchemy_evasion_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_evasion_buff"
end

function modifier_alchemy_evasion_buff:RemoveOnDeath()
	return false
end

function modifier_alchemy_evasion_buff:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
    }
    return funcs
end

function modifier_alchemy_evasion_buff:GetModifierEvasion_Constant()	
	return 30
end

