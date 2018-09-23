
if modifier_color_blue == nil then
    modifier_color_blue = class({})
end

function modifier_color_blue:IsHidden()
	return true
end

function modifier_color_blue:GetTexture()
    return "item_tango"
end

function modifier_color_blue:RemoveOnDeath()
	return true
end

function modifier_color_blue:DeclareFunctions()
    return nil
end


function modifier_color_blue:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(70, 130, 180) 
	end	
end
