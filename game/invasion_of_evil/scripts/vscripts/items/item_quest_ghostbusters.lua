
if item_quest_ghostbusters == nil then
	item_quest_ghostbusters = class({})
end


function item_quest_ghostbusters:OnSpellStart()
	if IsServer() then
	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		--main:CreateDrop("item_note_dungeon_cursed_one", hCaster:GetAbsOrigin())
		--main:CreateDrop("item_note_dungeon_jeepers_one", hCaster:GetAbsOrigin())
		--main:CreateDrop("item_note_alchemist_one", hCaster:GetAbsOrigin())
		--CustomGameEventManager:Send_ServerToPlayer(hCaster:GetPlayerOwner(),"QuestMsgPanel_create_new_message", {messageName = "#test_text", messageText = "#test_text_Description"})

		if not hCaster:HasModifier("modifier_achievement_ghostbusters") then
			hCaster:EmitSound("Item.TomeOfKnowledge")
			CustomGameEventManager:Send_ServerToPlayer(hCaster:GetPlayerOwner(),"QuestMsgPanel_create_new_message", {messageName = "#quest_ghostbusters", messageText = "#quest_ghostbusters_Description"})			
			hCaster:AddNewModifier(hCaster, nil, "modifier_quest_ghostbusters", {})
			hCaster:RemoveItem(self)	
		end
	end
end