
if modifier_summoner_wide_swing == nil then
    modifier_summoner_wide_swing = class({})
end

function modifier_summoner_wide_swing:IsHidden()
	return true
end

function modifier_summoner_wide_swing:GetTexture()
    return "life_stealer_feast"
end

function modifier_summoner_wide_swing:RemoveOnDeath()
	return true
end

function modifier_summoner_wide_swing:IsPurgable()
    return false
end

function modifier_summoner_wide_swing:IsPurgeException()
    return false
end

function modifier_summoner_wide_swing:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

--new_pos	Vector, process_procs, order_type, issuer_player_index, target, damage_category, reincarnate
--damage, ignore_invis, attacker, ranged_attack, record, activity, do_not_consume, damage_type, heart_regen_applied
--diffusal_applied, mkb_tested, distance, damage_flags, original_damage, cost, gain, basher_tested, fail_type

function modifier_summoner_wide_swing:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			DoCleaveAttack(data.attacker, data.target, self, data.damage/2, 50, 200, 350, "particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf")
		end
	end
end