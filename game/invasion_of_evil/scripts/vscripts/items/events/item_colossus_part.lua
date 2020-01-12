
if item_colossus_part == nil then
	item_colossus_part = class({})
end


function item_colossus_part:OnSpellStart()
	if IsServer() then

	--print("=======================blood_coin ================")

		local hCaster = self:GetCaster()
		local hItem = self

		if hCaster:HasModifier("modifier_events_colossus_part") then
			main_chap_two:CreateDrop("item_colossus_part", hCaster:GetAbsOrigin())  
		else
			hCaster:AddNewModifier(hCaster, self, "modifier_events_colossus_part", {}) 
		end
		
		hCaster:EmitSound("Item.TomeOfKnowledge")
		hCaster:RemoveItem(hItem)

	end
end