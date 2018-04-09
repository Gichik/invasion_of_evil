
if modifier_dishonored_fleetness == nil then
    modifier_dishonored_fleetness = class({})
end

function modifier_dishonored_fleetness:IsHidden()
	return true
end

function modifier_dishonored_fleetness:GetTexture()
    return "custom_folder/dishonored_fleetness"
end

function modifier_dishonored_fleetness:RemoveOnDeath()
	return false
end

function modifier_dishonored_fleetness:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
    return funcs
end

function modifier_dishonored_fleetness:GetModifierBonusStats_Agility()	
	return self:GetAbility():GetSpecialValueFor("bonus_agility") or 0
end
