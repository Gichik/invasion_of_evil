
if sapient_flows_of_magic == nil then
	sapient_flows_of_magic = class({})
end

function sapient_flows_of_magic:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function sapient_flows_of_magic:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_NONE
end

function sapient_flows_of_magic:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_NONE
end

function sapient_flows_of_magic:OnSpellStart()
   self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sapient_flows_of_magic", {})
   self:GetCaster():EmitSound("Hero_Necrolyte.SpiritForm.Cast")
end