
if modifier_berserk_crit == nil then
    modifier_berserk_crit = class({})
end

function modifier_berserk_crit:IsHidden()
	return true
end

function modifier_berserk_crit:GetTexture()
    return "axe_culling_blade"
end

function modifier_berserk_crit:RemoveOnDeath()
	return true
end

function modifier_berserk_crit:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_START
    }
    return funcs
end

function modifier_berserk_crit:OnAttackStart(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			if RollPercentage(self:GetAbility():GetSpecialValueFor("crit_chance")) then
				data.attacker:AddNewModifier(data.attacker, self, "modifier_berserk_crit_buff", {})
			end
		end
	end
end

---------------------------------------------------------------
modifier_berserk_crit_buff = class({})


function modifier_berserk_crit_buff:DeclareFunctions()
	local funcs = { 
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	 }
	return funcs
end

function modifier_berserk_crit_buff:GetModifierPreAttack_CriticalStrike()
	return 200
end

function modifier_berserk_crit_buff:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			self:Destroy()
		end
	end
end

function modifier_berserk_crit_buff:RemoveOnDeath()
	return true
end

function modifier_berserk_crit_buff:IsHidden()
	return true
end