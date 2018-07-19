
if modifier_puddle_of_poison == nil then
    modifier_puddle_of_poison = class({})
end

function modifier_puddle_of_poison:GetModifierAura()
    return "modifier_puddle_of_poison_debuff"
end

function modifier_puddle_of_poison:IsHidden()
	return true
end

function modifier_puddle_of_poison:RemoveOnDeath()
	return true
end

function modifier_puddle_of_poison:IsAura()
    return true
end

function modifier_puddle_of_poison:CanBeAddToMinions()
    return false
end

function modifier_puddle_of_poison:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("puddle_radius")
end

function modifier_puddle_of_poison:GetTexture()
    return "custom_folder/puddle_of_poison"
end

function modifier_puddle_of_poison:GetEffectName()
    return "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"
end

function modifier_puddle_of_poison:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_puddle_of_poison:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_puddle_of_poison:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_puddle_of_poison:GetAuraDuration()
    return self.auraDuration
end

function modifier_puddle_of_poison:OnCreated(data)
    self.auraDuration = 0.3
    if IsServer() then
    	if self:GetCaster() then
	    	self.particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", PATTACH_CUSTOMORIGIN, self)
	    	ParticleManager:SetParticleControl(self.particleID, 0, self:GetCaster().point )
	   		ParticleManager:SetParticleControl(self.particleID, 1, Vector(self:GetAbility():GetSpecialValueFor( "puddle_radius" ), 0, 0))
	   	end
    end
end

function modifier_puddle_of_poison:OnDestroy()
    if IsServer() then
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			ParticleManager:ReleaseParticleIndex(self.particleID)
			self.particleID = nil
		end
    end
end

--------------------------------------------------------------------------------

modifier_puddle_of_poison_debuff = class({})

function modifier_puddle_of_poison_debuff:DeclareFunctions()
    return nil
end

function modifier_puddle_of_poison_debuff:GetTexture()
    return "custom_folder/puddle_of_poison"
end

function modifier_puddle_of_poison_debuff:IsHidden()
    return false
end

function modifier_puddle_of_poison_debuff:IsDebuff()
	return true
end

function modifier_puddle_of_poison_debuff:RemoveOnDeath()
    return true
end

function modifier_puddle_of_poison_debuff:OnCreated(data)
	if IsServer() then
		self.dmg = 70
		self.attacker = self:GetCaster() or nil		
		self:StartIntervalThink(0.3) 
	end
end

function modifier_puddle_of_poison_debuff:OnIntervalThink()
	if self:GetCaster() and self:GetParent() then
	    ApplyDamage({
	        victim = self:GetParent(),
	        attacker = self.attacker,
	        damage = self.dmg,
	        damage_type = DAMAGE_TYPE_MAGICAL,
	        ability = self
	       })
	end
end