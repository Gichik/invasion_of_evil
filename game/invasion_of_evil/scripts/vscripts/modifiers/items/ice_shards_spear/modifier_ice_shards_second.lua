
if modifier_ice_shards_second == nil then
    modifier_ice_shards_second = class({})
end


function modifier_ice_shards_second:IsHidden()
	return false
end

function modifier_ice_shards_second:IsPurgable()
	return false
end

function modifier_ice_shards_second:GetTexture()
    return "winter_wyvern_splinter_blast"
end

function modifier_ice_shards_second:RemoveOnDeath()
	return true
end

function modifier_ice_shards_second:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_ice_shards_second:GetAbilityDamageType()	
	return DAMAGE_TYPE_MAGICAL
end


function modifier_ice_shards_second:GetModifierConstantManaRegen()	
	return -self.manaCost
end


function modifier_ice_shards_second:GetModifierAttackSpeedBonus_Constant()	
	return self.attackSpeedBonus or 0
end

function modifier_ice_shards_second:OnCreated(data)
	self.manaCost = 20
	self.attackSpeedBonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus") or 0	
	
	if IsServer() then
		self.parent = self:GetParent()
		self.dmgMultiply = self:GetAbility():GetSpecialValueFor("dmg_perc")/100 or 0		
		self.aoeRadius = 300
		self.shardCount = self:GetAbility():GetSpecialValueFor("shards_count") or 0	
		self.think = 0.03

		self.particle_id = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self.parent:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Cast")

		self:StartIntervalThink(self.think)
	end
end


function modifier_ice_shards_second:OnDestroy()
	if IsServer() then
		if self.particle_id then
			ParticleManager:DestroyParticle(self.particle_id, false)
			ParticleManager:ReleaseParticleIndex(self.particle_id)
			self.particle_id = nil
		end
	end
end

function modifier_ice_shards_second:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() <= 0 or not self.parent:IsAlive() then
			self:Destroy()
		end
	end
end

function modifier_ice_shards_second:OnAttackLanded(data)
	if IsServer() then
		if self:GetParent() then
			if data.attacker == self:GetParent() then
				data.target:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Target")
		        self:CreateShards(data.target)			
			end
		end
	end
end

function modifier_ice_shards_second:CreateShards(hTarget)
	if self:GetParent() then
		local goalCount = self.shardCount

		local units = FindUnitsInRadius( self.parent:GetTeamNumber(), hTarget:GetAbsOrigin(), self.parent, self.aoeRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			
		if units and #units > 1 then
			if goalCount > #units then
				goalCount = #units
			end

			for i = 1, goalCount do
				if units[ i ] ~= hTarget then
					ProjectileManager:CreateTrackingProjectile({
							EffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf",
							Ability = self:GetAbility(),
							iMoveSpeed = 500,
							Source = hTarget,
							Target = units[ i ],
							iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
						})
				end
			end

		end
	end
end