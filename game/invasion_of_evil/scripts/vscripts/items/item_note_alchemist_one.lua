
if item_note_alchemist_one == nil then
	item_note_alchemist_one = class({})
end


function item_note_alchemist_one:OnSpellStart()
	if IsServer() then

		--print("AlchemyNoteOnSpellStart")

		local hCaster = self:GetCaster()
		local hItem = self

		if not hCaster.alchemy_step and not hCaster:HasModifier("modifier_alchemy") then
			hCaster.alchemy_step = 1
			hCaster:EmitSound("Item.TomeOfKnowledge")
			CustomGameEventManager:Send_ServerToPlayer(
				hCaster:GetPlayerOwner(),
				"QuestMsgPanel_create_new_message",
				{messageName = "#note_alchemy_quest", messageText = "#note_alchemy_one_Description", quest = "alchemy", questClose = false}
			)
		else
			main:CreateDrop("item_note_alchemist_one", hCaster:GetAbsOrigin())
		end

		hCaster:RemoveItem(hItem)
	end
end