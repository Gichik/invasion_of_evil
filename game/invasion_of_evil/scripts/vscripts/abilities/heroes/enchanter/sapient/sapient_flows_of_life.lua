
if sapient_flows_of_life == nil then
	sapient_flows_of_life = class({})
end

function sapient_flows_of_life:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function sapient_flows_of_life:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_NONE
end

function sapient_flows_of_life:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_NONE
end


function sapient_flows_of_life:OnToggle()
	if self:GetToggleState() then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sapient_flows_of_life", {})
		self:GetCaster():EmitSound("Hero_Necrolyte.SpiritForm.Cast")
	else
		self:GetCaster():RemoveModifierByName("modifier_sapient_flows_of_life")
	end
end

