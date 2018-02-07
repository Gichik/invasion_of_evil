
if modifier_chain_lightning_second == nil then
    modifier_chain_lightning_second = class({})
end


function modifier_chain_lightning_second:IsHidden()
	return false
end

function modifier_chain_lightning_second:IsPurgable()
	return false
end

function modifier_chain_lightning_second:GetTexture()
    return "zuus_lightning_bolt"
end

function modifier_chain_lightning_second:RemoveOnDeath()
	return true
end

function modifier_chain_lightning_second:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_chain_lightning_second:GetAbilityDamageType()	
	return DAMAGE_TYPE_MAGICAL
end


function modifier_chain_lightning_second:GetModifierConstantManaRegen()	
	return -self.manaCost
end


function modifier_chain_lightning_second:OnCreated(data)
	self.manaCost = 20
	
	if IsServer() then
		self.parent = self:GetParent()
		self.dmgMultiply = self:GetAbility():GetSpecialValueFor("int_in_dmg_perc")/100 or 0
		self.aoeRadius = 500
		self.lightCount = 4
		self.think = 0.03

		self.particle_id = ParticleManager:CreateParticle("particles/items2_fx/mjollnir_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self.parent:EmitSound("DOTA_Item.Mjollnir.Activate")

		self:StartIntervalThink(self.think)
	end
end

function modifier_chain_lightning_second:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() <= 0 or not self.parent:IsAlive() then
			self:Destroy()
		end
	end
end

function modifier_chain_lightning_second:OnAttackLanded(data)
	if IsServer() then
		if self:GetParent() then
			if data.attacker == self:GetParent() then
				data.target:EmitSound("Hero_Zuus.ArcLightning.Cast")
		        ApplyDamage({
		            victim = data.target,
		            attacker = self.parent,
		            damage = self.parent:GetIntellect(),
		            damage_type = self:GetAbilityDamageType(),
		            ability = self
		           })			

				self:ApplyDamage(data.target)
			end
		end
	end
end


function modifier_chain_lightning_second:OnDestroy()
	if IsServer() then
		if self.particle_id then
			ParticleManager:DestroyParticle(self.particle_id, false)
			ParticleManager:ReleaseParticleIndex(self.particle_id)
			self.particle_id = nil
		end
		if self:GetParent() then
			self.parent:StopSound("DOTA_Item.Mjollnir.Activate")
			self.parent:EmitSound("DOTA_Item.Mjollnir.DeActivate")
		end
	end
end

--анимация проигрывается от предыдущего к текущему

function modifier_chain_lightning_second:ApplyDamage(target)
	if self:GetParent() then

		local dmg = self.dmgMultiply*self.parent:GetIntellect()

		local goalCount = self.lightCount
		local units = FindUnitsInRadius( self.parent:GetTeamNumber(), target:GetAbsOrigin(), self.parent, self.aoeRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units and #units > 1 then
			for i = 1, #units do
				if units[ i ] == target then
					table.remove(units,i)
					break
				end
			end

			table.insert(units, 1, target)
			
			if #units < self.lightCount then
				goalCount = #units
			end

			for i = 2, goalCount do
				Timers:CreateTimer("ChainLightningTimer_" .. units[ i ]:GetEntityIndex(), {
				useGameTime = true,
				endTime = 0.2*(i-1),
				callback = function()
					if units[i] then
						units[i]:EmitSound("Hero_Zuus.ArcLightning.Target")

						if units[i-1] then
							modifier_chain_lightning_second:PlayAnimation(units[i-1], units[i])
						end

				        ApplyDamage({
				            victim = units[ i ],
				            attacker = self.parent,
				            damage = dmg,
				            damage_type = self:GetAbilityDamageType(),
				            ability = self
				           })
					end
				  	return nil
				end
				})				
			end
		end

	end
end

function modifier_chain_lightning_second:PlayAnimation(oldTarget, NewTarget)
	if oldTarget and NewTarget then	
		local pID = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", PATTACH_WORLDORIGIN, oldTarget)
		ParticleManager:SetParticleControl(pID,0,oldTarget:GetAbsOrigin())   
		ParticleManager:SetParticleControl(pID,1,NewTarget:GetAbsOrigin())
	end
end