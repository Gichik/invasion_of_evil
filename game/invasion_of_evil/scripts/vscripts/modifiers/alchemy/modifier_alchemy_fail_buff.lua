
if modifier_alchemy_fail_buff == nil then
    modifier_alchemy_fail_buff = class({})
end

function modifier_alchemy_fail_buff:IsHidden()
	return false
end

function modifier_alchemy_fail_buff:GetTexture()
    return "alchemist_unstable_concoction_throw"
end

function modifier_alchemy_fail_buff:RemoveOnDeath()
	return true
end

function modifier_alchemy_fail_buff:DeclareFunctions()
    return nil
end



