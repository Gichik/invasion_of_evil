
if item_blood_coin == nil then
	item_blood_coin = class({})
end

EVENT_BLOOD_COIN_COUNT = 0

function item_blood_coin:OnSpellStart()
	if IsServer() then

	--print("=======================blood_coin ================")

		local hCaster = self:GetCaster()
		local hItem = self

		if EVENT_REWARD == 0 then
			--print(EVENT_BLOOD_COIN_COUNT)
			EVENT_BLOOD_COIN_COUNT = EVENT_BLOOD_COIN_COUNT + 1
			CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = EVENT_BLOOD_COIN_COUNT, maxScore = EVENT_BLOOD_COIN_MAX})

			if EVENT_BLOOD_COIN_COUNT >= EVENT_BLOOD_COIN_MAX then
				--print("Change reward")
				EVENT_BLOOD_COIN_COUNT = 0
				main_chap_two:SetEventReward(1)
				CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_close",  {})
			end
		end


		hCaster:EmitSound("Item.PickUpRingShop")
		hCaster:RemoveItem(hItem)

	end
end