
if modifier_echoes_victims == nil then
    modifier_echoes_victims = class({})
end

function modifier_echoes_victims:GetModifierAura()
    return "modifier_echoes_victims_debuff"
end

function modifier_echoes_victims:IsHidden()
	return true
end

function modifier_echoes_victims:RemoveOnDeath()
	return true
end

function modifier_echoes_victims:IsAura()
    return true
end

function modifier_echoes_victims:CanBeAddToMinions()
    return false
end

function modifier_echoes_victims:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("hands_radius")
end

function modifier_echoes_victims:GetTexture()
    return "custom_folder/echoes_victims"
end

function modifier_echoes_victims:GetEffectName()
    return "particles/units/heroes/hero_bane/bane_fiendsgrip_hands.vpcf"
end

function modifier_echoes_victims:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_echoes_victims:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_echoes_victims:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_echoes_victims:GetAuraDuration()
    return self.auraDuration
end

function modifier_echoes_victims:OnCreated(data)
    self.auraDuration = 0.3
end

function modifier_echoes_victims:OnDestroy()
	if IsServer() then

	end
end

--------------------------------------------------------------------------------

modifier_echoes_victims_debuff = class({})

function modifier_echoes_victims_debuff:DeclareFunctions()
    return nil
end

function modifier_echoes_victims_debuff:GetTexture()
    return "custom_folder/echoes_victims"
end

function modifier_echoes_victims_debuff:IsHidden()
    return false
end

function modifier_echoes_victims_debuff:IsDebuff()
	return true
end

function modifier_echoes_victims_debuff:RemoveOnDeath()
    return true
end

--[[function modifier_echoes_victims_debuff:GetEffectName()
    return "particles/units/heroes/hero_bane/bane_fiendsgrip_ground_rubble.vpcf"
end]]

function modifier_echoes_victims_debuff:OnCreated(data)
	if IsServer() then
		self.dmg = 50
		self.attacker = self:GetCaster() or nil		
		self:StartIntervalThink(0.3) 
	end
end

function modifier_echoes_victims_debuff:OnIntervalThink()
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