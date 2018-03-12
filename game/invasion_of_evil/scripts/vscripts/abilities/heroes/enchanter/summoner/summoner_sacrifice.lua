
if summoner_sacrifice == nil then
	summoner_sacrifice = class({})
end

function summoner_sacrifice:GetCastAnimation()
    return ACT_DOTA_TAUNT
end

function summoner_sacrifice:GetAbilityTargetTeam()
    return DOTA_UNIT_TARGET_TEAM_NONE
end

function summoner_sacrifice:GetAbilityTargetType()
    return DOTA_UNIT_TARGET_NONE
end


function summoner_sacrifice:CastFilterResult()
	--print("Error")
	if IsServer() then
		if self:GetCaster() then
			if not self:GetCaster().controllableUnit then
				return UF_FAIL_CUSTOM
			end

			if self:GetCaster().controllableUnit:IsNull() then
				return UF_FAIL_CUSTOM
			end

			if self:GetCaster().controllableUnit:IsAlive() then
				return UF_SUCCESS
			end
		end
		return UF_FAIL_CUSTOM		
	end
end


function summoner_sacrifice:GetCustomCastError()
	--print("Error")
	if IsServer() then
		if self:GetCaster() then
			if not self:GetCaster().controllableUnit then
				return "#dota_hud_havent_summon"
			end

			if self:GetCaster().controllableUnit:IsNull() then
				return "#dota_hud_havent_summon"
			end

			if self:GetCaster().controllableUnit:IsAlive() then
				return UF_SUCCESS
			end
		end	
		return "#dota_hud_havent_summon"
	end
end


function summoner_sacrifice:OnSpellStart()
	if self:GetCaster() then
		if self:GetCaster().controllableUnit then
			self.caster = self:GetCaster()
			self.heal = self:GetCaster():GetMaxHealth()*self:GetSpecialValueFor("recovery_perc")/100
			self.resMana = self:GetCaster():GetMaxMana()*self:GetSpecialValueFor("recovery_perc")/100
			self.caster.controllableUnit:ForceKill(false)
			self.caster:Heal(self.heal,self.caster)
			self.caster:GiveMana(self.resMana)
			ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_hand_of_god_fallback_mid.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
			self:GetCaster():EmitSound("Hero_Chen.HandOfGodHealHero")
		end
	end
end