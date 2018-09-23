
if modifier_color_red == nil then
    modifier_color_red = class({})
end

function modifier_color_red:IsHidden()
	return true
end

function modifier_color_red:GetTexture()
    return "item_tango"
end

function modifier_color_red:RemoveOnDeath()
	return true
end

function modifier_color_red:DeclareFunctions()
    return nil
end


function modifier_color_red:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(220, 20, 60)
	end	
end
