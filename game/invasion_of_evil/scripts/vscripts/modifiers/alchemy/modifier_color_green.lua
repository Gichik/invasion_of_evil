
if modifier_color_green == nil then
    modifier_color_green = class({})
end

function modifier_color_green:IsHidden()
	return true
end

function modifier_color_green:GetTexture()
    return "item_tango"
end

function modifier_color_green:RemoveOnDeath()
	return true
end

function modifier_color_green:DeclareFunctions()
    return nil
end


function modifier_color_green:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(50, 205, 50) 
	end	
end
