if summoner_aesculapius == nil then
	summoner_aesculapius = class({})
end

function summoner_aesculapius:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function summoner_aesculapius:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_NONE
end

function summoner_aesculapius:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_NONE
end

function summoner_aesculapius:GetCooldown()
	if self:GetCaster().reduceCD then
		return 120 - self:GetCaster().reduceCD
	end
    return 120
end

function summoner_aesculapius:GetSummonName()
    return "npc_aesculapius"
end

function summoner_aesculapius:GetSummonModifierName()
    return "modifier_summoner_aesculapius"
end


function summoner_aesculapius:OnSpellStart()
	self.hCaster = self:GetCaster()
	self.unit = nil
	self.synAbility = self.hCaster:FindAbilityByName("summoner_synergy")

	if self.hCaster.controllableUnit then
		if not self.hCaster.controllableUnit:IsNull() then
			if self.hCaster.controllableUnit:IsAlive() then
				self.hCaster.controllableUnit:ForceKill(false)
			end
		end
	end


	if self.synAbility and self.synAbility:GetLevel() > 0 then
		--print("summoner_synergy")
		self.hCaster:AddNewModifier(self.hCaster, self, self:GetSummonModifierName(), {duration = self.synAbility:GetSpecialValueFor("duration") })
	else
	   	self.unit = CreateUnitByName(self:GetSummonName(), self.hCaster:GetAbsOrigin(), true, self.hCaster, self.hCaster, self.hCaster:GetTeamNumber())
	   
	   	if self.unit then
		   	self.unit:SetControllableByPlayer(self.hCaster:GetPlayerOwnerID(), true)
		   	--FindClearSpaceForUnit(self.unit, self.caster:GetAbsOrigin(), true)
		   	self.unit:CreatureLevelUp(self:GetLevel()-1)
		   	self.unit:AddNewModifier(self.unit, self, self:GetSummonModifierName(), {})

		   	self:AddAbilityModifierToSummonUnit(self.hCaster:FindAbilityByName("summoner_natural_density"))
		   	self:AddAbilityModifierToSummonUnit(self.hCaster:FindAbilityByName("summoner_vampirism"))
		   	self:AddAbilityModifierToSummonUnit(self.hCaster:FindAbilityByName("summoner_internal_power"))

		   	self.hCaster.controllableUnit = self.unit
		end
	end

end


function summoner_aesculapius:AddAbilityModifierToSummonUnit(ability)
   	if ability and self.unit then
   		if ability:GetLevel() > 0 then
   			self.unit:AddNewModifier(self.hCaster, ability, "modifier_" .. ability:GetAbilityName(), {})
   		end
   	end
end