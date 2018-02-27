
if modifier_aoe_hex == nil then
    modifier_aoe_hex = class({})
end

function modifier_aoe_hex:IsHidden()
	return true
end

function modifier_aoe_hex:GetTexture()
    return "shadow_shaman_voodoo"
end

function modifier_aoe_hex:RemoveOnDeath()
	return true
end

function modifier_aoe_hex:CanBeAddToMinions()
    return false
end

function modifier_aoe_hex:DeclareFunctions()
    return nil
end

function modifier_aoe_hex:OnCreated() 
	if IsServer() then
		self.caster = self:GetCaster()
		self:StartIntervalThink(20) 
	end
end

function modifier_aoe_hex:OnIntervalThink()
	if self:GetCaster() then
		local units = FindUnitsInRadius( self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), self.caster, 1000,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units then
			for i = 1, #units do
				units[i]:AddNewModifier(self.caster, nil, "modifier_hexed_tree", {duration = 5})
			end
		end	
	end
end


-------------------------------------------------------------------------

modifier_hexed_tree = class({})

function modifier_hexed_tree:IsHidden()
    return false
end

function modifier_hexed_tree:RemoveOnDeath()
    return true
end

function modifier_hexed_tree:GetTexture()
    return "shadow_shaman_voodoo"
end

function modifier_hexed_tree:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_hexed_tree:CheckState() 
  local state = {
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_MUTED] = true,
    [MODIFIER_STATE_HEXED] = true,
    [MODIFIER_STATE_EVADE_DISABLED] = true,
    [MODIFIER_STATE_SILENCED] = true,
  }
  return state
end


function modifier_hexed_tree:GetModifierModelChange()
    return "models/items/shredder/controlled_burn/mesh/controlled_burn_tree_fx.vmdl"
end


function modifier_hexed_tree:GetModifierMoveSpeedBonus_Constant()	
	return -200
end