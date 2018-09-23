modifier_npc_invulnerable = class({})

function modifier_npc_invulnerable:CheckState() 
  local state = {
      [MODIFIER_STATE_INVULNERABLE] = true
  }

  return state
end

function modifier_npc_invulnerable:IsHidden()
    return true
end

function modifier_npc_invulnerable:GetTexture()
    return "vengefulspirit_nether_swap"
end
