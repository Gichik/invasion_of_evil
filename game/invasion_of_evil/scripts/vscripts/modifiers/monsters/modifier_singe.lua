
if modifier_singe == nil then
    modifier_singe = class({})
end

function modifier_singe:IsHidden()
	return false
end

function modifier_singe:IsDebuff()
	return true
end

function modifier_singe:GetTexture()
    return "invoker_exort"
end

function modifier_singe:RemoveOnDeath()
	return true
end

function modifier_singe:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
    return funcs
end

function modifier_singe:GetModifierIncomingDamage_Percentage()	
	return self:GetStackCount() * 9
end

function modifier_singe:OnCreated()
	if IsServer() then

	end
end


