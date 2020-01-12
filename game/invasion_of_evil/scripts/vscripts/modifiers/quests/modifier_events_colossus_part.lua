

modifier_events_colossus_part = class({})

EVENT_COLLOSUS_PART_COUNT = 0

function modifier_events_colossus_part:DeclareFunctions()
    return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end

function modifier_events_colossus_part:GetModifierMoveSpeedBonus_Constant()	
	return -150
end

function modifier_events_colossus_part:GetTexture()
    return "warlock_upheaval"
end

function modifier_events_colossus_part:IsHidden()
    return false
end

function modifier_events_colossus_part:RemoveOnDeath()
    return true
end

function modifier_events_colossus_part:GetEffectName()
    return "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf"
end

function modifier_events_colossus_part:OnCreated(data)
    self.parent = self:GetParent()
    self.parent.colossus_part_build = false
end

function modifier_events_colossus_part:OnDestroy(data)
    if IsServer() and self.parent then
        if self.parent.colossus_part_build and EVENT_REWARD == 0 then

            EVENT_COLLOSUS_PART_COUNT = EVENT_COLLOSUS_PART_COUNT + 1
            CustomGameEventManager:Send_ServerToAllClients("QuestPanel_UpdateEventScorebar",  {currentScore = EVENT_COLLOSUS_PART_COUNT, maxScore = EVENT_COLLOSUS_PART_MAX})
          
            if EVENT_COLLOSUS_PART_COUNT >= EVENT_COLLOSUS_PART_MAX then
                --print("Change reward")
                EVENT_COLLOSUS_PART_COUNT = 0
                main_chap_two:SetEventReward(2)
                CustomGameEventManager:Send_ServerToAllClients("QuestMsgPanel_close",  {})
            end

        else
            main_chap_two:CreateDrop("item_colossus_part", self.parent:GetAbsOrigin())
        end

    end
end
