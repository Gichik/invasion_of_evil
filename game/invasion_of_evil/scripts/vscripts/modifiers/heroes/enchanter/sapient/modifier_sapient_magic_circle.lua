

if modifier_sapient_magic_circle == nil then
    modifier_sapient_magic_circle = class({})
end

function modifier_sapient_magic_circle:GetTexture()
    return "arc_warden_magnetic_field"
end

function modifier_sapient_magic_circle:IsHidden()
	return true
end

function modifier_sapient_magic_circle:RemoveOnDeath()
	return false
end

function modifier_sapient_magic_circle:IsAura()
    return true
end

function modifier_sapient_magic_circle:GetModifierAura()
    return "modifier_sapient_magic_circle_buff"
end

function modifier_sapient_magic_circle:GetAuraRadius()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor( "aoe_radius" )
    end
    return 0
end

function modifier_sapient_magic_circle:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_sapient_magic_circle:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sapient_magic_circle:GetAuraDuration()
    return self.auraDuration
end

function modifier_sapient_magic_circle:OnCreated(data)
    self.auraDuration = 0.3

    if IsServer() then
    	self.particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", PATTACH_CUSTOMORIGIN, self)
    	ParticleManager:SetParticleControl(self.particleID, 0, self:GetCaster().magic_circle_point )
   		ParticleManager:SetParticleControl(self.particleID, 1, Vector(self:GetAuraRadius(), 0, 0))
    end
end

function modifier_sapient_magic_circle:OnDestroy()
    if IsServer() then
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			ParticleManager:ReleaseParticleIndex(self.particleID)
			self.particleID = nil
		end
    end
end
--------------------------------------------------------------------------------

modifier_sapient_magic_circle_buff = class({})


function modifier_sapient_magic_circle_buff:IsHidden()
	return true
end

function modifier_sapient_magic_circle_buff:GetTexture()
    return "arc_warden_magnetic_field"
end

function modifier_sapient_magic_circle_buff:RemoveOnDeath()
	return true
end

function modifier_sapient_magic_circle_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_sapient_magic_circle_buff:GetModifierConstantHealthRegen()
	return self:GetStackCount() or 0
end

function modifier_sapient_magic_circle_buff:GetModifierConstantManaRegen()
	return self:GetStackCount() or 0
end

function modifier_sapient_magic_circle_buff:OnCreated()
    if IsServer() then
    	self.caster = self:GetCaster()
    	self.parent = self:GetParent()

    	if  self.caster and self.parent then
		    self:SetStackCount(self.caster.magic_circle_regen)
		    self.parent:AddNewModifier(self.caster, self.caster:FindAbilityByName("sapient_magic_circle"), "modifier_sapient_magic_circle_immune", {})
	    end
    end
end

function modifier_sapient_magic_circle_buff:OnDestroy()
    if IsServer() then
    	if self:GetParent() then 
			self:GetParent():RemoveModifierByName("modifier_sapient_magic_circle_immune")
		end
    end
end

--------------------------------------------------------------------------------

modifier_sapient_magic_circle_immune = class({})

function modifier_sapient_magic_circle_immune:CheckState() 
  local state = {
      [MODIFIER_STATE_MAGIC_IMMUNE] = true,
  }
  return state
end

function modifier_sapient_magic_circle_immune:GetTexture()
    return "arc_warden_magnetic_field"
end

function modifier_sapient_magic_circle_immune:IsHidden()
    return false
end

function modifier_sapient_magic_circle_immune:RemoveOnDeath()
    return true
end

