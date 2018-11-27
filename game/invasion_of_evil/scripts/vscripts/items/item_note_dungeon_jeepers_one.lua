
if item_note_dungeon_jeepers_one == nil then
	item_note_dungeon_jeepers_one = class({})
end

function item_note_dungeon_jeepers_one:OnSpellStart()
	if IsServer() then

		--print("ChurchNoteOnSpellStart")

		local hCaster = self:GetCaster()
		local hItem = self

		if not hCaster.church_step and not hCaster:HasModifier("modifier_quest_dungeon_jeepers") then
			hCaster.church_step = 1
			hCaster:EmitSound("Item.TomeOfKnowledge")
			CustomGameEventManager:Send_ServerToPlayer(
				hCaster:GetPlayerOwner(),
				"QuestMsgPanel_create_new_message",
				{messageName = "#note_church_dungeon", messageText = "#note_dungeon_church_one_Description", quest = "church", questClose = false}
			)
		else
			main:CreateDrop("item_note_dungeon_jeepers_one", hCaster:GetAbsOrigin())
		end

		hCaster:RemoveItem(hItem)
	end
end