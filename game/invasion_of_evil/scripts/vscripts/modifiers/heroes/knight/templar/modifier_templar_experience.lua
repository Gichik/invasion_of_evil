
if modifier_templar_experience == nil then
    modifier_templar_experience = class({})
end

function modifier_templar_experience:IsHidden()
	return true
end

function modifier_templar_experience:GetTexture()
    return "custom_folder/templar_experience"
end

function modifier_templar_experience:RemoveOnDeath()
	return false
end

function modifier_templar_experience:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_templar_experience:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			if RollPercentage(self:GetAbility():GetSpecialValueFor("stun_chance")) then

			    local units = FindUnitsInRadius( data.attacker:GetTeamNumber(), data.target:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("aoe_radius"),
			    DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			    
			    if units then   
			        for i = 1, #units do
			        	units[ i ]:AddNewModifier(data.attacker, self, "modifier_templar_experience_debuff", {duration = 1})
			        end
			    end				
				
			end
		end
	end
end

---------------------------------------------------------------
modifier_templar_experience_debuff = class({})

function modifier_templar_experience_debuff:CheckState() 
  local state = {
      [MODIFIER_STATE_STUNNED] = true,
  }

  return state
end

function modifier_templar_experience_debuff:DeclareFunctions()
    local funcs = {
       MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_templar_experience_debuff:GetOverrideAnimation()
	return ACT_DOTA_IDLE_SLEEPING
end

function modifier_templar_experience_debuff:IsHidden()
    return true
end

function modifier_templar_experience_debuff:GetTexture()
    return "custom_folder/templar_experience"
end

function modifier_templar_experience_debuff:OnCreated()
	if IsServer() then
		EmitSoundOn("DOTA_Item.SkullBasher", self:GetParent())
		self.pID =	ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	end
end

function modifier_templar_experience_debuff:OnDestroy()
	if IsServer() then
		if self.pID then
			ParticleManager:DestroyParticle(self.pID, false)
			ParticleManager:ReleaseParticleIndex(self.pID)
			self.pID = nil
		end
	end
end