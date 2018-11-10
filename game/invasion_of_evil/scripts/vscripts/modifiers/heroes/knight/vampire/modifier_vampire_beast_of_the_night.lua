
if modifier_vampire_beast_of_the_night == nil then
    modifier_vampire_beast_of_the_night = class({})
end

function modifier_vampire_beast_of_the_night:IsHidden()
	return true
end

function modifier_vampire_beast_of_the_night:GetTexture()
    return "night_stalker_hunter_in_the_night"
end

function modifier_vampire_beast_of_the_night:RemoveOnDeath()
	return true
end

function modifier_vampire_beast_of_the_night:DeclareFunctions()
    return nil
end

function modifier_vampire_beast_of_the_night:IsPurgable()
    return false
end

function modifier_vampire_beast_of_the_night:IsPurgeException()
    return false
end


function modifier_vampire_beast_of_the_night:OnCreated()
	self.parent = self:GetParent()

	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_vampire_beast_of_the_night:OnIntervalThink()
	if self:GetParent() then 
		if GameRules:IsDaytime() then
			self.parent:RemoveModifierByName("modifier_vampire_beast_of_the_night_buff")
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_vampire_beast_of_the_night_debuff", {})
		else
			self.parent:RemoveModifierByName("modifier_vampire_beast_of_the_night_debuff")
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_vampire_beast_of_the_night_buff", {})
		end
	end
end


-----------------------------------------------

modifier_vampire_beast_of_the_night_debuff = class({})

function modifier_vampire_beast_of_the_night_debuff:IsHidden()
	return true
end

function modifier_vampire_beast_of_the_night_debuff:GetTexture()
    return "shadow_demon_demonic_purge"
end

function modifier_vampire_beast_of_the_night_debuff:RemoveOnDeath()
	return false
end

function modifier_vampire_beast_of_the_night_debuff:IsPurgable()
    return false
end

function modifier_vampire_beast_of_the_night_debuff:IsPurgeException()
    return false
end

function modifier_vampire_beast_of_the_night_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_vampire_beast_of_the_night_debuff:GetModifierAttackSpeedBonus_Constant()
	return -1*self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

function modifier_vampire_beast_of_the_night_debuff:GetModifierMoveSpeedBonus_Constant()	
	return -1*self:GetAbility():GetSpecialValueFor("bonus_movement_speed") or 0
end

-----------------------------------------------

modifier_vampire_beast_of_the_night_buff = class({})

function modifier_vampire_beast_of_the_night_buff:IsHidden()
	return true
end

function modifier_vampire_beast_of_the_night_buff:GetTexture()
    return "night_stalker_hunter_in_the_night"
end

function modifier_vampire_beast_of_the_night_buff:RemoveOnDeath()
	return false
end

function modifier_vampire_beast_of_the_night_buff:IsPurgable()
    return false
end

function modifier_vampire_beast_of_the_night_buff:IsPurgeException()
    return false
end

function modifier_vampire_beast_of_the_night_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_vampire_beast_of_the_night_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") or 0
end

function modifier_vampire_beast_of_the_night_buff:GetModifierMoveSpeedBonus_Constant()	
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed") or 0
end



