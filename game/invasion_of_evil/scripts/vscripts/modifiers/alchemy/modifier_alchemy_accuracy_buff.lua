modifier_alchemy_accuracy_buff = class({})

function modifier_alchemy_accuracy_buff:CheckState() 
  local state = {
      [MODIFIER_STATE_CANNOT_MISS] = true,
  }

  return state
end

function modifier_alchemy_accuracy_buff:IsHidden()
    return false
end

function modifier_alchemy_accuracy_buff:RemoveOnDeath()
    return true
end

function modifier_alchemy_accuracy_buff:GetTexture()
    return "custom_folder/alchemy/alchemy_accuracy_buff"
end
