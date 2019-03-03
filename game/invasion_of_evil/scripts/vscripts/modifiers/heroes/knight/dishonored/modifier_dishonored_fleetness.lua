
if modifier_dishonored_fleetness == nil then
    modifier_dishonored_fleetness = class({})
end

function modifier_dishonored_fleetness:IsHidden()
	return false
end

function modifier_dishonored_fleetness:GetTexture()
    return "custom_folder/dishonored_fleetness"
end

function modifier_dishonored_fleetness:RemoveOnDeath()
	return false
end

function modifier_dishonored_fleetness:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
    return funcs
end

function modifier_dishonored_fleetness:GetModifierBonusStats_Agility()
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_agi") or 0
end

--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_dishonored_fleetness:OnDeath(data)
	if IsServer() and self:GetParent() then
		if data.unit:GetUnitName():find("boss") then

			local ParentAbsOrigin = self:GetParent():GetAbsOrigin()
			local UnitAbsOrigin = data.unit:GetAbsOrigin()

			if 	ParentAbsOrigin.x > UnitAbsOrigin.x - 500 and 
				ParentAbsOrigin.x < UnitAbsOrigin.x + 500 and
				ParentAbsOrigin.y > UnitAbsOrigin.y - 500 and
				ParentAbsOrigin.y < UnitAbsOrigin.y + 500 then

				if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max_stacks") then
					EmitSoundOn("Hero_Undying.SoulRip.Cast", data.unit)
					local parent = self:GetParent();
					local particleID = ParticleManager:CreateParticle( "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", PATTACH_ABSORIGIN, parent)
					ParticleManager:SetParticleControl(particleID, 0, data.unit:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(particleID, 1, parent, PATTACH_ABSORIGIN, "", parent:GetAbsOrigin(), true )
					ParticleManager:ReleaseParticleIndex(particleID)
					self:IncrementStackCount()
				end
				
			end
		end
	end
end