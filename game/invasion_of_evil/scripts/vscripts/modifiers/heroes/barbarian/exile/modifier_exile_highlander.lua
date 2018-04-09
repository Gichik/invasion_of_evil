
if modifier_exile_highlander == nil then
    modifier_exile_highlander = class({})
end

function modifier_exile_highlander:IsHidden()
	return false
end

function modifier_exile_highlander:GetTexture()
    return "custom_folder/exile_highlander"
end

function modifier_exile_highlander:RemoveOnDeath()
	return false
end

function modifier_exile_highlander:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
    return funcs
end

function modifier_exile_highlander:GetModifierBonusStats_Strength()
	return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("bonus_str") or 0
end

--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_exile_highlander:OnDeath(data)
	if IsServer() and self:GetParent() then
		if data.unit:GetUnitName() == "npc_mini_boss" then
			if data.attacker == self:GetParent() then
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