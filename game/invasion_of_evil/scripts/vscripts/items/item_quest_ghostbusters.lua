
if item_quest_ghostbusters == nil then
	item_quest_ghostbusters = class({})
end


function item_quest_ghostbusters:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()

		if not hCaster:HasModifier("modifier_achievement_ghostbusters") then
			hCaster:EmitSound("Item.TomeOfKnowledge")
			hCaster:AddNewModifier(hCaster, nil, "modifier_quest_ghostbusters", {})
			hCaster:RemoveItem(self)
		end
	end
end