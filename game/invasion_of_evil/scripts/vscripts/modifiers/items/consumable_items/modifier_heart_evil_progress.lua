modifier_heart_evil_progress = class({})


function modifier_heart_evil_progress:IsHidden()
	return false
end


function modifier_heart_evil_progress:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end


function modifier_heart_evil_progress:GetTexture()
    return "warlock_rain_of_chaos"
end


function modifier_heart_evil_progress:GetModifierMagicalResistanceBonus()	
	return self:GetStackCount()*self.magicResBonus or 0
end


function modifier_heart_evil_progress:GetModifierConstantHealthRegen()	
	return self:GetStackCount()*self.hpRegenBonus or 0
end

function modifier_heart_evil_progress:OnCreated( data )
	self.magicResBonus = 15
	self.hpRegenBonus = 7
end

function modifier_heart_evil_progress:RemoveOnDeath()
	return false
end