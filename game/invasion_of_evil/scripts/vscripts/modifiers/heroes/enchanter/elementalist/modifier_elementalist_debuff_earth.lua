modifier_elementalist_debuff_earth = class({})


function modifier_elementalist_debuff_earth:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_elementalist_debuff_earth:GetEffectName()
   	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end


function modifier_elementalist_debuff_earth:IsHidden()
    return false
end

function modifier_elementalist_debuff_earth:GetTexture()
    return "life_stealer_assimilate_eject"
end

function modifier_elementalist_debuff_earth:GetModifierMoveSpeedBonus_Constant()
	if self.reduce_ms then
		return -self.reduce_ms
	end
	return 0
end


function modifier_elementalist_debuff_earth:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.interval = 0 
		self.reduce_ms = 0
		self.convPerc = 0
		self.dmg = 0

		if self.ability then
			self.interval = self.ability:GetSpecialValueFor("damage_interval") 
			self.reduce_ms = self.ability:GetSpecialValueFor("reduce_ms") 
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

function modifier_elementalist_debuff_earth:OnIntervalThink()
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