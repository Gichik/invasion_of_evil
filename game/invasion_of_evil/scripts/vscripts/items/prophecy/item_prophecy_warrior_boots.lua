
if item_prophecy_warrior_boots == nil then
	item_prophecy_warrior_boots = class({})
end


function item_prophecy_warrior_boots:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		hCaster:EmitSound("Item.LotusOrb.Target")
		ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_loadout.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		if hCaster.mProphecyName then
			hCaster:RemoveModifierByName(hCaster.mProphecyName)
		end
	
		hCaster:AddNewModifier(hCaster, nil, "modifier_prophecy_warrior_boots", {})
		hCaster:RemoveItem(self)
	end
end