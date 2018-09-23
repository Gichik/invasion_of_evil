
if item_three_ingot_of_magical_metal == nil then
	item_three_ingot_of_magical_metal = class({})
end


function item_three_ingot_of_magical_metal:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		hCaster:EmitSound("DOTA_Item.Buckler.Activate")
		hCaster:RemoveItem(self)
		hCaster:AddItemByName("item_casting_shape")
	end
end

