
if modifier_strychnine_dagger_second == nil then
    modifier_strychnine_dagger_second = class({})
end

function modifier_strychnine_dagger_second:IsHidden()
	return false
end

function modifier_strychnine_dagger_second:IsPurgable()
	return false
end

function modifier_strychnine_dagger_second:GetTexture()
    return "venomancer_venomous_gale"
end

function modifier_strychnine_dagger_second:RemoveOnDeath()
	return true
end

function modifier_strychnine_dagger_second:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_strychnine_dagger_second:GetAbilityDamageType()	
	return DAMAGE_TYPE_PHYSICAL
end

function modifier_strychnine_dagger_second:GetModifierConstantManaRegen()	
	return -self.manaCost
end


function modifier_strychnine_dagger_second:OnCreated(data)
	self.manaCost = 20

	if IsServer() then
		self.parent = self:GetParent()
		self.dmgMultiply = self:GetAbility():GetSpecialValueFor("agi_in_dmg_perc")/100 or 0
		self.maxStacks = self:GetAbility():GetSpecialValueFor("max_stacks") or 0
		self.think = 0.03
		
		self.particle_id = ParticleManager:CreateParticle("particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self.parent:EmitSound("DOTA_Item.SpiritVessel.Cast")

		self:StartIntervalThink(self.think)
	end
end

function modifier_strychnine_dagger_second:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() <= 0 or not self.parent:IsAlive() then
			self:Destroy()
		end
	end
end

function modifier_strychnine_dagger_second:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_netherblast_fluidexp.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.target)
			self.parent:EmitSound("Hero_Venomancer.VenomousGale")	
			self:ApplyPoison(data.target)	
		end
	end
end


function modifier_strychnine_dagger_second:OnDestroy()
	if IsServer() then
		if self.particle_id then
			ParticleManager:DestroyParticle(self.particle_id, false)
			ParticleManager:ReleaseParticleIndex(self.particle_id)
			self.particle_id = nil
		end
	end
end

function modifier_strychnine_dagger_second:ApplyPoison(target)
	if self:GetParent() then
		local damage =  self.dmgMultiply*self.parent:GetAgility()
		local modifier = nil
		local units = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.parent, 250,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units then
			for i = 1, #units do
				modifier = units[ i ]:FindModifierByName("modifier_strychnine")
				if modifier then
					if modifier:GetStackCount() < self.maxStacks then
						modifier:IncrementStackCount()
					end
					modifier:ForceRefresh()
				else
					modifier = units[ i ]:AddNewModifier(self.parent, self:GetAbility(), "modifier_strychnine", {duration = 3, poisonDmg = damage})	
					modifier:IncrementStackCount()
				end
			end
		end
	end
end

