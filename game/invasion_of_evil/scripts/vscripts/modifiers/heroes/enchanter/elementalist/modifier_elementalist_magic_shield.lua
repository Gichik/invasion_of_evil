
if modifier_elementalist_magic_shield == nil then
    modifier_elementalist_magic_shield = class({})
end

function modifier_elementalist_magic_shield:IsHidden()
	return true
end

function modifier_elementalist_magic_shield:GetTexture()
    return "medusa_mana_shield"
end

function modifier_elementalist_magic_shield:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_shield:DeclareFunctions()
    return nil
end

function modifier_elementalist_magic_shield:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.buff = nil

		if self.caster and self.ability then
			self:StartIntervalThink(0.1) 
		end
	end
end

--[[
в таком вварианте почему-то пиздец

function modifier_elementalist_magic_shield:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.buff = nil

		if self.caster and self.ability then
			self.buff = self.caster:AddNewModifier(self.caster, self.ability, "modifier_elementalist_magic_shield_buff", {})
			if self.buff then
				self.buff:IncrementStackCount()
				--self.ability:StartCooldown(self.ability:GetCooldown(self.ability:GetLevel()))
				self:StartIntervalThink(0.5) 
			end
		end
	end
end

]]


function modifier_elementalist_magic_shield:OnRefresh()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
	end
end

function modifier_elementalist_magic_shield:OnIntervalThink()
	if self.caster and self.ability then
		if self.ability:IsCooldownReady() then

			self.buff = self.caster:FindModifierByName("modifier_elementalist_magic_shield_buff")

			if not self.buff then
				self.buff = self.caster:AddNewModifier(self.caster, self.ability, "modifier_elementalist_magic_shield_buff", {})
			end

			if self.buff:GetStackCount() < self.ability:GetSpecialValueFor("max_stacks") then
				self.buff:IncrementStackCount()
				--self.ability:StartCooldown(self.ability:GetCooldown(self.ability:GetLevel()))
			end

			self.buff.absDmg = self.ability:GetSpecialValueFor("absorption_damage")			

		end   
	end
end

---------------------------------------------------------------------


modifier_elementalist_magic_shield_buff = class({})


function modifier_elementalist_magic_shield_buff:IsHidden()
	return true
end

function modifier_elementalist_magic_shield_buff:GetTexture()
    return "medusa_mana_shield"
end

function modifier_elementalist_magic_shield_buff:GetEffectName()
	--print("EffectName")
   	return "particles/items3_fx/lotus_orb_shell.vpcf"
end

function modifier_elementalist_magic_shield_buff:RemoveOnDeath()
	return true
end

function modifier_elementalist_magic_shield_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,       
    }
    return funcs
end


function modifier_elementalist_magic_shield_buff:OnCreated()
	if IsServer() then
		--print("OnCreated")
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.absDmg = 0
		self.debuffName = nil
		self.debuffDur = 0
		self.castRange = 0	

		if self.ability then
			self.absDmg = self.ability:GetSpecialValueFor("absorption_damage")
			self.debuffName = self.ability:GetAbilityKeyValues()["DebuffName"]
			self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")	
			self.castRange = self.ability:GetCastRange()	
		end

		self.incomeDmg = 0
		self.caster:EmitSound("Hero_Abaddon.AphoticShield.Cast")
	end
end

function modifier_elementalist_magic_shield_buff:OnRefresh()
	if IsServer() then
		--print("OnRefresh")
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.absDmg = 0
		self.debuffName = nil
		self.debuffDur = 0	
		self.castRange = 0	

		if self.ability then
			self.absDmg = self.ability:GetSpecialValueFor("absorption_damage")
			self.debuffName = self.ability:GetAbilityKeyValues()["DebuffName"]
			self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")	
			self.castRange = self.ability:GetCastRange()	
		end
	end
end


function modifier_elementalist_magic_shield_buff:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			--print(self.incomeDmg)
			self.incomeDmg = self.incomeDmg + data.damage
			if self.incomeDmg > self.absDmg then
				self.incomeDmg = 0
				self:Explosion()
			end
		end
	end
end


function modifier_elementalist_magic_shield_buff:Explosion()

	--print("explosion")
	if self.caster and self.ability and self.debuffName then

		local units = FindUnitsInRadius( self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), self.caster, self.castRange,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

		if units then	
			for i = 1, #units do
				if units[i] then
					local modifier = units[i]:FindModifierByName(self.debuffName)
					
					if not modifier then					
						modifier = units[i]:AddNewModifier(self.caster,  self.ability, self.debuffName, {duration = self.debuffDur})	
					end
					modifier:ForceRefresh()
				end	
			end
		end

		ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
		self.ability:StartCooldown(self.ability:GetCooldown(self.ability:GetLevel()-1))
		self.caster:EmitSound("Hero_Abaddon.AphoticShield.Destroy")	
	end

	if self:GetStackCount() > 1 then
		self:DecrementStackCount()
	else
		self:Destroy()
	end

end