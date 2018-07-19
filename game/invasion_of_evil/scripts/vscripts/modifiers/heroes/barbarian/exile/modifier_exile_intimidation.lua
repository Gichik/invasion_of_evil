
if modifier_exile_intimidation == nil then
    modifier_exile_intimidation = class({})
end

function modifier_exile_intimidation:IsHidden()
	return true
end

function modifier_exile_intimidation:GetTexture()
    return "beastmaster_primal_roar"
end

function modifier_exile_intimidation:RemoveOnDeath()
	return false
end

function modifier_exile_intimidation:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

function modifier_exile_intimidation:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			if RollPercentage(self:GetAbility():GetSpecialValueFor("stun_chance")) then
				
				local parent = self:GetParent()
				EmitSoundOn("Hero_Beastmaster.Primal_Roar", parent)
			    local units = FindUnitsInRadius(	parent:GetTeamNumber(), 
			    									parent:GetAbsOrigin(),
			    									nil,
			    									self:GetAbility():GetCastRange(),
			    									DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE,
			    									0,
			    									false
			    								)
			    
			    if units then   
			        for i = 1, #units do
			        	units[ i ]:AddNewModifier(parent, self, "modifier_exile_intimidation_debuff", {duration = 0.5})
			        end
			    end				
				
			end
		end
	end
end

---------------------------------------------------------------
modifier_exile_intimidation_debuff = class({})

function modifier_exile_intimidation_debuff:CheckState() 
  local state = {
      [MODIFIER_STATE_STUNNED] = true,
  }

  return state
end

function modifier_exile_intimidation_debuff:DeclareFunctions()
    local funcs = {
       MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_exile_intimidation_debuff:GetOverrideAnimation()
	return ACT_DOTA_IDLE_SLEEPING
end

function modifier_exile_intimidation_debuff:IsHidden()
    return true
end

function modifier_exile_intimidation_debuff:GetTexture()
    return "beastmaster_primal_roar"
end

function modifier_exile_intimidation_debuff:OnCreated()
	if IsServer() then
		self.pID =	ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	end
end

function modifier_exile_intimidation_debuff:OnDestroy()
	if IsServer() then
		if self.pID then
			ParticleManager:DestroyParticle(self.pID, false)
			ParticleManager:ReleaseParticleIndex(self.pID)
			self.pID = nil
		end
	end
end