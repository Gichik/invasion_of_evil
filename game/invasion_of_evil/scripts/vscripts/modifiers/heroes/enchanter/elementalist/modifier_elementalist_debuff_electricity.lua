modifier_elementalist_debuff_electricity = class({})


function modifier_elementalist_debuff_electricity:DeclareFunctions()
    return nil
end

function modifier_elementalist_debuff_electricity:GetEffectName()
   	--return "particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt_elec.vpcf"
   	return nil
end


function modifier_elementalist_debuff_electricity:IsHidden()
    return false
end

function modifier_elementalist_debuff_electricity:GetTexture()
    return "storm_spirit_electric_vortex"
end


function modifier_elementalist_debuff_electricity:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.interval = 0
		self.stun_dur = 0 
		self.convPerc = 0
		self.dmg = 0
		
		if self.ability then
			self.interval = self.ability:GetSpecialValueFor("damage_interval") 
			self.stun_dur = self.ability:GetSpecialValueFor("stun_duration")
			self.convPerc = self.ability:GetSpecialValueFor("debuff_damage_perc")  			
		end

		if self.caster then
			self.dmg = self.caster:GetAverageTrueAttackDamage(self:GetParent()) * self.convPerc/100
		end

		if self.interval then
			self:StartIntervalThink(self.interval) 
		end

	end
end

function modifier_elementalist_debuff_electricity:OnIntervalThink()
	local hAttacker = self:GetParent()
	local hAbility = self

	if self.caster and self.ability then
	    if not self.caster:IsNull() and not self.ability:IsNull() then
	    	self.convPerc = self.ability:GetSpecialValueFor("debuff_damage_perc")
	    	self.dmg = self.caster:GetAverageTrueAttackDamage(self:GetParent()) * self.convPerc/100
			hAttacker = self.caster
			hAbility = self.ability
	    end
	end

	
    ApplyDamage({
        victim = self:GetParent(),
        attacker = hAttacker,
        damage = self.dmg,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = hAbility,
        damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
       })
	
	ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:GetParent():AddNewModifier(hAttacker, hAbility, "modifier_stunned", {duration = self.stun_dur})
end