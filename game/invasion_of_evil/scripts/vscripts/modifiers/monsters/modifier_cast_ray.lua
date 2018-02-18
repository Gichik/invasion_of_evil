
modifier_cast_ray = class({})

function modifier_cast_ray:CheckState() 
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_cast_ray:IsHidden()
    return true
end

function modifier_cast_ray:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_cast_ray:GetOverrideAnimation()
    return ACT_DOTA_ATTACK_EVENT
end
