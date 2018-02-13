modifier_teleport_progress = class({})


function modifier_teleport_progress:IsHidden()
	return false
end


function modifier_teleport_progress:DeclareFunctions()
	return { }
end


function modifier_teleport_progress:GetTexture()
    return "custom_folder/teleport_progress"
end


function modifier_teleport_progress:OnCreated( data )

end

function modifier_teleport_progress:RemoveOnDeath()
	return false
end