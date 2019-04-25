
modifier_signal_animation = class({})

function modifier_signal_animation:CheckState() 
	local state = {
		[MODIFIER_STATE_FLYING] = true,
		--[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

function modifier_signal_animation:IsHidden()
    return true
end

function modifier_signal_animation:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,		
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_signal_animation:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end


function modifier_signal_animation:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_signal_animation:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_signal_animation:GetAbsoluteNoDamagePure()
    return 1
end