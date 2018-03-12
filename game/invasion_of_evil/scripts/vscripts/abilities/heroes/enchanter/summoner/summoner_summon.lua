


function SummonUnit(data)
	if data.caster and data.UnitName then
		local unit = nil

		if data.caster.controllableUnit then
			if not data.caster.controllableUnit:IsNull() then
				if data.caster.controllableUnit:IsAlive() then
					data.caster.controllableUnit:ForceKill(false)
				end
			end
		end

	   	unit = CreateUnitByName(data.UnitName, data.caster:GetAbsOrigin(), true, data.caster, data.caster, data.caster:GetTeamNumber())
	   
	   	if unit then
		   	unit:SetControllableByPlayer(data.caster:GetPlayerOwnerID(), true)
		   	--FindClearSpaceForUnit(self.unit, self.caster:GetAbsOrigin(), true)
		   	unit:CreatureLevelUp(data.ability:GetLevel()-1)
		   		
	
		   	if data.ability:GetAbilityName() == "summoner_predator" then
		   		unit:AddNewModifier(unit, data.ability, "modifier_summoner_predator", {})
		   	end

		   	if data.ability:GetAbilityName() == "summoner_aesculapius" then
		   		unit:AddNewModifier(unit, data.ability, "modifier_summoner_aesculapius", {})
		   	end

		   	if data.ability:GetAbilityName() == "summoner_mammock" then
		   		unit:AddNewModifier(unit, data.ability, "modifier_summoner_mammock", {})
		   	end

		   	AdddAbilityToSummonUnit(data.caster:FindAbilityByName("summoner_natural_density_dummy"), unit)
		   	AdddAbilityToSummonUnit(data.caster:FindAbilityByName("summoner_internal_power_dummy"), unit)
		   	AdddAbilityToSummonUnit(data.caster:FindAbilityByName("summoner_vampirism_dummy"), unit)
		   	AdddAbilityToSummonUnit(data.caster:FindAbilityByName("summoner_third_eye_dummy"), unit)

		   	data.caster.controllableUnit = unit
		end
	end
end

function AdddAbilityToSummonUnit(ability,unit)
   	if ability then
   		local abilityName = string.gsub(ability:GetAbilityName(),"_dummy","")
   		if ability:GetLevel() > 0 then
   			unit:AddAbility(abilityName):SetLevel(ability:GetLevel())
   		end
   	end
end

function UpgradeAbilityOnUnit(data)
	if data.caster then
		if data.caster.controllableUnit and data.ability then
			if not data.caster.controllableUnit:IsNull() then
				if data.caster.controllableUnit:IsAlive() then
					local abilityName = string.gsub(data.ability:GetAbilityName(),"_dummy","")
					local ability = data.caster.controllableUnit:FindAbilityByName(abilityName)
					if ability then
						ability:UpgradeAbility(false)
					else
						data.caster.controllableUnit:AddAbility(abilityName)
					end
				end
			end
		end
	end
end