
if item_prophecy_ring_of_the_basilius == nil then
	item_prophecy_ring_of_the_basilius = class({})
end


function item_prophecy_ring_of_the_basilius:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		hCaster:EmitSound("Item.LotusOrb.Target")
		ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_loadout.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		if hCaster.mProphecyName then
			hCaster:RemoveModifierByName(hCaster.mProphecyName)
		end
	
		hCaster:AddNewModifier(hCaster, nil, "modifier_prophecy_ring_of_the_basilius", {})
		hCaster:RemoveItem(self)
	end
end