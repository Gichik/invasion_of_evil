
if modifier_dishonored_insidious == nil then
    modifier_dishonored_insidious = class({})
end

function modifier_dishonored_insidious:IsHidden()
	return true
end

function modifier_dishonored_insidious:GetTexture()
    return "custom_folder/dishonorable_cunning"
end

function modifier_dishonored_insidious:RemoveOnDeath()
	return false
end

function modifier_dishonored_insidious:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_dishonored_insidious:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			if self:GetAbility() then
				local ability = self:GetAbility()
				if ability:IsCooldownReady() then
					if RollPercentage(ability:GetSpecialValueFor("insidious_chance")) then
						ability:StartCooldown(ability:GetCooldown(1))
						data.attacker:AddNewModifier(data.attacker, ability, "modifier_dishonored_insidious_buff", {duration = 0.3})
				        

						local units = FindUnitsInRadius( 	self:GetParent():GetTeamNumber(), 
															self:GetParent():GetAbsOrigin(), 
															self:GetParent(), 
															ability:GetCastRange(),
															DOTA_UNIT_TARGET_TEAM_ENEMY, 
															DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 
															DOTA_UNIT_TARGET_FLAG_NONE,
															 0, false )
							
						if units then	
							for i = 1, #units do
								if 	units[ i ] then
							        ApplyDamage({
							            victim = units[ i ],
							            attacker = self:GetParent(),
							            damage = data.damage,
							            damage_type = DAMAGE_TYPE_PHYSICAL,
							            ability = ability
							           })
							        ParticleManager:CreateParticle("particles/items2_fx/soul_ring_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, units[ i ])			
								end	
							end
						end	

					end
				end
			end
		end
	end
end

---------------------------------------------------------------
modifier_dishonored_insidious_buff = class({})

function modifier_dishonored_insidious_buff:DeclareFunctions()
    local funcs = {
       MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
    return funcs
end

function modifier_dishonored_insidious_buff:GetOverrideAnimation()
	return ACT_DOTA_CAST_ABILITY_2
end

function modifier_dishonored_insidious_buff:IsHidden()
    return true
end

function modifier_dishonored_insidious_buff:GetTexture()
    return "custom_folder/dishonorable_cunning"
end

function modifier_dishonored_insidious_buff:OnCreated()
	if IsServer() then
		EmitSoundOn("Hero_BountyHunter.Jinada", self:GetParent())
	end
end
