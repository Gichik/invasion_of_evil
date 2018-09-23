
if item_note_alchemist_fifth == nil then
	item_note_alchemist_fifth = class({})
end


function item_note_alchemist_fifth:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		hCaster:EmitSound("Item.TomeOfKnowledge")	
		if not 	hCaster:HasModifier("modifier_alchemy") then
			hCaster:AddNewModifier(hCaster, nil, "modifier_alchemy", {})
		end
		hCaster:RemoveItem(self)
	end
end