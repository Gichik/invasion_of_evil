
if modifier_fallen_commander == nil then
    modifier_fallen_commander = class({})
end

function modifier_fallen_commander:IsHidden()
	return false
end

function modifier_fallen_commander:GetTexture()
    return "dark_troll_warlord_raise_dead"
end

function modifier_fallen_commander:RemoveOnDeath()
	return false
end

function modifier_fallen_commander:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,         
    }
    return funcs
end

function modifier_fallen_commander:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()*self.attackSpeedBonus or 0
end

function modifier_fallen_commander:GetModifierMagicalResistanceBonus()	
	return self:GetStackCount()*self.magicResistBonus or 0
end

function modifier_fallen_commander:GetModifierIncomingPhysicalDamage_Percentage()		
	return self:GetStackCount()*self.physArmorBonus or 0
end

function modifier_fallen_commander:OnDeath(data)
	if IsServer() and self.parent then
		if data.unit:GetUnitName() == "npc_cemetery_minion" then
			if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max_charges") then
				self:IncrementStackCount()
			end
		end
	end
end

function modifier_fallen_commander:OnCreated(table)
	self.attackSpeedBonus = 30
	self.magicResistBonus = 9
	self.physArmorBonus = -9

	if IsServer() and self:GetParent() then
		self.parent = self:GetParent()
		self:SetStackCount(10)
		self:StartIntervalThink(5)
	end
end

function modifier_fallen_commander:OnIntervalThink()
	local ability = self:GetAbility()
	if ability and self.parent then
		if ability:IsCooldownReady() then
			for i = 1, self:GetStackCount() do
        		CreateUnitByName("npc_cemetery_minion", self.parent:GetAbsOrigin() + RandomVector(300), true, nil, nil, DOTA_TEAM_NEUTRALS )
        	end
        	self:SetStackCount(0)
        	ability:StartCooldown(ability:GetCooldown(1))
		end		
	end
end