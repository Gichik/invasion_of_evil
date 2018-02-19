modifier_heart_evil_progress = class({})


function modifier_heart_evil_progress:IsHidden()
	return false
end


function modifier_heart_evil_progress:DeclareFunctions()
	return nil
end


function modifier_heart_evil_progress:GetTexture()
    return "warlock_rain_of_chaos"
end


function modifier_heart_evil_progress:OnCreated( data )

end

function modifier_heart_evil_progress:RemoveOnDeath()
	return false
end