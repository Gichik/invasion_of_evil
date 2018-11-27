
if item_note_dungeon_cursed_one == nil then
	item_note_dungeon_cursed_one = class({})
end

function item_note_dungeon_cursed_one:OnSpellStart()
	if IsServer() then

		--print("CursedNoteOnSpellStart")

		local hCaster = self:GetCaster()
		local hItem = self

		if not hCaster.cursed_step and not hCaster:HasModifier("modifier_quest_dungeon_cursed") then
			hCaster.cursed_step = 1
			hCaster:EmitSound("Item.TomeOfKnowledge")
			CustomGameEventManager:Send_ServerToPlayer(
				hCaster:GetPlayerOwner(),
				"QuestMsgPanel_create_new_message",
				{messageName = "#note_cursed_dungeon", messageText = "#note_dungeon_cursed_one_Description", quest = "cursed", questClose = false}
			)
		else
			main:CreateDrop("item_note_dungeon_cursed_one", hCaster:GetAbsOrigin())
		end

		hCaster:RemoveItem(hItem)
	end
end