
if item_note_dungeon_cemetry_one == nil then
	item_note_dungeon_cemetry_one = class({})
end

function item_note_dungeon_cemetry_one:OnSpellStart()
	if IsServer() then

		--print("ChurchNoteOnSpellStart")

		local hCaster = self:GetCaster()
		local hItem = self

		if not hCaster.cemetry_step and not hCaster:HasModifier("modifier_quest_dungeon_cemetry") then
			hCaster.cemetry_step = 1
			hCaster:EmitSound("Item.TomeOfKnowledge")
			CustomGameEventManager:Send_ServerToPlayer(
				hCaster:GetPlayerOwner(),
				"QuestMsgPanel_create_new_message",
				{messageName = "#note_cemetry_dungeon", messageText = "#note_dungeon_cemetry_one_Description", quest = "cemetry", questClose = false}
			)
		else
			main:CreateDrop("item_note_dungeon_cemetry_one", hCaster:GetAbsOrigin())
		end

		hCaster:RemoveItem(hItem)
	end
end