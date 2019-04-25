
if item_prophecy_planeswalkers_cloak == nil then
	item_prophecy_planeswalkers_cloak = class({})
end


function item_prophecy_planeswalkers_cloak:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		hCaster:EmitSound("Item.LotusOrb.Target")
		ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_loadout.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		if hCaster.mProphecyName then
			hCaster:RemoveModifierByName(hCaster.mProphecyName)
		end
	
		hCaster:AddNewModifier(hCaster, nil, "modifier_prophecy_planeswalkers_cloak", {})
		hCaster:RemoveItem(self)
	end
end