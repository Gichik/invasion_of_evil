
if modifier_berserk_stun == nil then
    modifier_berserk_stun = class({})
end

function modifier_berserk_stun:IsHidden()
	return true
end

function modifier_berserk_stun:GetTexture()
    return "lone_druid_rabid"
end

function modifier_berserk_stun:RemoveOnDeath()
	return true
end

function modifier_berserk_stun:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_berserk_stun:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			if RollPercentage(self:GetAbility():GetSpecialValueFor("stun_chance")) then
				data.target:AddNewModifier(data.attacker, self, "modifier_berserk_stun_debuff", {duration = 1})
			end
		end
	end
end

---------------------------------------------------------------
modifier_berserk_stun_debuff = class({})

function modifier_berserk_stun_debuff:CheckState() 
  local state = {
      [MODIFIER_STATE_STUNNED] = true,
  }

  return state
end

function modifier_berserk_stun_debuff:DeclareFunctions()
    local funcs = {
       MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_berserk_stun_debuff:GetOverrideAnimation()
	return ACT_DOTA_IDLE_SLEEPING
end

function modifier_berserk_stun_debuff:IsHidden()
    return true
end

function modifier_berserk_stun_debuff:GetTexture()
    return "lone_druid_rabid"
end

function modifier_berserk_stun_debuff:OnCreated()
	if IsServer() then
		EmitSoundOn("DOTA_Item.SkullBasher", self:GetParent())
		self.pID =	ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	end
end

function modifier_berserk_stun_debuff:OnDestroy()
	if IsServer() then
		if self.pID then
			ParticleManager:DestroyParticle(self.pID, false)
			ParticleManager:ReleaseParticleIndex(self.pID)
			self.pID = nil
		end
	end
end