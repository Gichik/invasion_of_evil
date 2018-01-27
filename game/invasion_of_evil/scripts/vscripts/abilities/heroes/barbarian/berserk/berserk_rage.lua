
if berserk_rage == nil then
    berserk_rage = class({})
end

--function berserk_rage:GetTexture()
--    return "medusa_mana_shield"
--end


 function berserk_rage:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE 
     return behav
 end

function berserk_rage:OnUpgrade()
	if IsServer() then
		print("OnUpgrade")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_berserk_rage", {})
	end
end