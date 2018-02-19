
if modifier_burning == nil then
    modifier_burning = class({})
end

function modifier_burning:GetModifierAura()
    return "modifier_burning_debuff"
end

function modifier_burning:IsHidden()
	return false
end

function modifier_burning:RemoveOnDeath()
	return true
end

function modifier_burning:IsAura()
    return true
end

function modifier_burning:CanBeAddToMinions()
    return true
end

function modifier_burning:GetAuraRadius()
    return self.auraRadius
end

function modifier_burning:GetTexture()
    return "invoker_exort"
end

function modifier_burning:GetEffectName()
    return "particles/items2_fx/radiance_owner.vpcf"
end

function modifier_burning:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_burning:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_burning:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_burning:GetAuraDuration()
    return self.auraDuration
end

function modifier_burning:OnCreated()
    self.auraRadius = 2000
    self.auraDuration = 0.3
end

function modifier_burning:OnDestroy()
	if IsServer() then

	end
end

--------------------------------------------------------------------------------

modifier_burning_debuff = class({})

function modifier_burning_debuff:DeclareFunctions()
    return nil
end

function modifier_burning_debuff:GetTexture()
    return "invoker_exort"
end

function modifier_burning_debuff:IsHidden()
    return false
end

function modifier_burning_debuff:IsDebuff()
	return true
end

function modifier_burning_debuff:RemoveOnDeath()
    return true
end

function modifier_burning_debuff:GetEffectName()
    return "particles/items2_fx/radiance.vpcf"
end

function modifier_burning_debuff:OnCreated(data)
	if IsServer() then
		self.burnDmg = 50
		self.attacker = self:GetCaster() or nil		
		self:StartIntervalThink(1.0) 
	end
end

function modifier_burning_debuff:OnIntervalThink()
	if self:GetCaster() and self:GetParent() then
	    ApplyDamage({
	        victim = self:GetParent(),
	        attacker = self.attacker,
	        damage = self.burnDmg,
	        damage_type = DAMAGE_TYPE_MAGICAL,
	        ability = self
	       })
	end
end