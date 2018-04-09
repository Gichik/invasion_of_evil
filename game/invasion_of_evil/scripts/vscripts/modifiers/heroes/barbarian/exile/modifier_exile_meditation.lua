
if modifier_exile_meditation == nil then
    modifier_exile_meditation = class({})
end

function modifier_exile_meditation:IsHidden()
	return false
end

function modifier_exile_meditation:GetTexture()
    return "earth_spirit_stone_caller"
end

function modifier_exile_meditation:RemoveOnDeath()
	return false
end

function modifier_exile_meditation:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
       	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_exile_meditation:GetModifierConstantManaRegen()	
	return self:GetAbility():GetSpecialValueFor("bonus_mp_regen") or 0
end

function modifier_exile_meditation:GetModifierConstantHealthRegen()	
	return self:GetAbility():GetSpecialValueFor("bonus_hp_regen") or 0
end


function modifier_exile_meditation:OnCreated()
	self.parent = self:GetParent()
end

function modifier_exile_meditation:OnTakeDamage(data)
	if IsServer() and self:GetParent() then
		if data.unit == self:GetParent() then
			self.parent:AddNewModifier(	self.parent,
										self:GetAbility(),
										"modifier_exile_meditation_debuff",
										{duration = self:GetAbility():GetSpecialValueFor("delay")})
			self:Destroy();
		end
	end
end

function modifier_exile_meditation:OnAttack(data)
	if IsServer() and self:GetParent() then
		if data.attacker == self:GetParent() then
			self.parent:AddNewModifier(	self.parent,
										self:GetAbility(),
										"modifier_exile_meditation_debuff",
										{duration = self:GetAbility():GetSpecialValueFor("delay")})
			self:Destroy();
		end
	end
end

-----------------------------------------------

modifier_exile_meditation_debuff = class({})

function modifier_exile_meditation_debuff:IsHidden()
	return true
end

function modifier_exile_meditation_debuff:GetTexture()
    return "earth_spirit_geomagnetic_grip"
end

function modifier_exile_meditation_debuff:RemoveOnDeath()
	return false
end

function modifier_exile_meditation_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK
    }
    return funcs
end

function modifier_exile_meditation_debuff:OnTakeDamage(data)
	if IsServer() and self:GetParent() then
		if data.unit == self:GetParent() then
			self:ForceRefresh()
		end
	end
end

function modifier_exile_meditation_debuff:OnAttack(data)
	if IsServer() and self:GetParent() then
		if data.attacker == self:GetParent() then
			self:ForceRefresh()
		end
	end
end

function modifier_exile_meditation_debuff:OnDestroy()
	if IsServer() and self:GetParent() then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_exile_meditation", {})
	end
end