
if modifier_cleave_sword_third == nil then
    modifier_cleave_sword_third = class({})
end

function modifier_cleave_sword_third:IsHidden()
	return false
end

function modifier_cleave_sword_third:IsPurgable()
	return false
end

function modifier_cleave_sword_third:GetTexture()
    return "centaur_double_edge"
end

function modifier_cleave_sword_third:RemoveOnDeath()
	return true
end

function modifier_cleave_sword_third:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_cleave_sword_third:GetAbilityDamageType()	
	return DAMAGE_TYPE_PHYSICAL
end

function modifier_cleave_sword_third:GetModifierConstantManaRegen()	
	return -self.manaCost
end

function modifier_cleave_sword_third:GetModifierPreAttack_BonusDamage()	
	return self.damageBonus
end

function modifier_cleave_sword_third:OnCreated(data)
	self.manaCost = 30
	self.damageBonus = self:GetAbility():GetSpecialValueFor("bonus_dmg") or 0
	
	if IsServer() then
		self.parent = self:GetParent()
		self.dmgMultiply = self:GetAbility():GetSpecialValueFor("dmg_perc")/100 or 0
		self.cleaveStRadius = 100
		self.cleaveEndRadius = 500
		self.cleaveDistance = 500
		self.think = 0.03

		self.particle_id = ParticleManager:CreateParticle("particles/units/heroes/hero_clinkz/clinkz_strafe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self.parent:EmitSound("Hero_Clinkz.Strafe")

		self:StartIntervalThink(self.think)
	end
end

function modifier_cleave_sword_third:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() <= 0 or not self.parent:IsAlive() then
			self:Destroy()
		end
	end
end

function modifier_cleave_sword_third:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			self.parent:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
			self:ApplyDamage(data.target)
		end
	end
end


function modifier_cleave_sword_third:OnDestroy()
	if IsServer() then
		if self.particle_id then
			ParticleManager:DestroyParticle(self.particle_id, false)
			ParticleManager:ReleaseParticleIndex(self.particle_id)
			self.particle_id = nil
		end
	end
end

function modifier_cleave_sword_third:ApplyDamage(target)
	if self:GetParent() then
		local damage =  self.dmgMultiply*self.parent:GetAverageTrueAttackDamage(target)
		local particle = "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength_crit.vpcf"
		DoCleaveAttack(self.parent, target, self, damage, self.cleaveStRadius, self.cleaveEndRadius, self.cleaveDistance, particle)
	end
end