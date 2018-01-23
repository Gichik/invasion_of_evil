
if modifier_chain_lightning == nil then
    modifier_chain_lightning = class({})
end


function modifier_chain_lightning:IsHidden()
	return false
end

function modifier_chain_lightning:IsPurgable()
	return false
end

function modifier_chain_lightning:GetTexture()
    return "zuus_lightning_bolt"
end

function modifier_chain_lightning:RemoveOnDeath()
	return true
end

function modifier_chain_lightning:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_chain_lightning:GetAbilityDamageType()	
	return DAMAGE_TYPE_MAGICAL
end

function modifier_chain_lightning:GetAbilityDamage()	
	return self.damage
end

function modifier_chain_lightning:GetModifierConstantManaRegen()	
	return -self.manaCost
end


function modifier_chain_lightning:OnCreated(data)
	self.manaCost = 10
	
	if IsServer() then
		self.parent = self:GetParent()
		self.damage = self.parent:GetIntellect() or 0
		self.aoeRadius = 500
		self.lightCount = 4
		self.think = 0.03

		self:StartIntervalThink(self.think)
	end
end

function modifier_chain_lightning:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() <= 0 or not self.parent:IsAlive() then
			self:Destroy()
		end
	end
end

function modifier_chain_lightning:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			self:ApplyDamage(data.target)
		end
	end
end


function modifier_chain_lightning:OnDestroy()
	if IsServer() then

	end
end

--анимация проигрывается от предыдущего к текущему

function modifier_chain_lightning:ApplyDamage(target)
	if self:GetParent() then

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

						if units[i-1] then
							modifier_chain_lightning:PlayAnimation(units[i-1], units[i])
						end

				        ApplyDamage({
				            victim = units[ i ],
				            attacker = self.parent,
				            damage = self.damage,
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

function modifier_chain_lightning:PlayAnimation(oldTarget, NewTarget)
	if oldTarget and NewTarget then	
		local pID = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", PATTACH_WORLDORIGIN, oldTarget)
		ParticleManager:SetParticleControl(pID,0,oldTarget:GetAbsOrigin())   
		ParticleManager:SetParticleControl(pID,1,NewTarget:GetAbsOrigin())
	end
end