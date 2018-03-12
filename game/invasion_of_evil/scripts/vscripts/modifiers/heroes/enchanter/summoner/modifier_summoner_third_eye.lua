
if modifier_summoner_third_eye == nil then
    modifier_summoner_third_eye = class({})
end

function modifier_summoner_third_eye:IsHidden()
	return true
end

function modifier_summoner_third_eye:GetTexture()
    return "custom_folder/third_eye"
end

function modifier_summoner_third_eye:RemoveOnDeath()
	return true
end

function modifier_summoner_third_eye:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_START
    }
    return funcs
end

function modifier_summoner_third_eye:OnAttackStart(data)
    if IsServer() then
        if data.attacker == self:GetParent() and self:GetAbility() then
            if RollPercentage(self:GetAbility():GetSpecialValueFor("accuracy_perc")) then
                data.attacker:AddNewModifier(data.attacker, self, "modifier_summoner_third_eye_buff", {duration = 1})
            end
        end
    end
end

-------------------------------------------------
modifier_summoner_third_eye_buff = class({})

function modifier_summoner_third_eye_buff:CheckState() 
  local state = {
      [MODIFIER_STATE_CANNOT_MISS] = true,
  }

  return state
end

function modifier_summoner_third_eye_buff:IsHidden()
    return true
end

