modifier_elementalist_debuff_ice = class({})

function modifier_elementalist_debuff_ice:CheckState() 
	local state = {
	  [MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_elementalist_debuff_ice:GetEffectName()
   	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end


function modifier_elementalist_debuff_ice:IsHidden()
    return false
end

function modifier_elementalist_debuff_ice:GetTexture()
    return "winter_wyvern_cold_embrace"
end

function modifier_elementalist_debuff_ice:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.interval = 0 
		self.convPerc = 0
		self.dmg = 0
		
		if self.ability then
			self.interval = self.ability:GetSpecialValueFor("damage_interval") 
			self.convPerc = self.ability:GetSpecialValueFor("debuff_damage_perc")			
		end

		if self.caster then
			self.dmg = self.caster:GetAverageTrueAttackDamage(self:GetParent()) * self.convPerc/100
		end

		if self.interval then
			self:StartIntervalThink(self.interval) 
		end

		if self:GetParent() then
			self:GetParent():EmitSound("hero_Crystal.frostbite")
		end

	end
end

function modifier_elementalist_debuff_ice:OnIntervalThink()
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
	
end