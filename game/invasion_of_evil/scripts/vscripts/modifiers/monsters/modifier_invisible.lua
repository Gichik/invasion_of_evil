modifier_invisible = class({})

function modifier_invisible:CheckState() 
  local state = {
      [MODIFIER_STATE_INVISIBLE] = true,
  }

  return state
end

function modifier_invisible:IsHidden()
    return true
end

function modifier_invisible:GetTexture()
    return "vengefulspirit_nether_swap"
end
