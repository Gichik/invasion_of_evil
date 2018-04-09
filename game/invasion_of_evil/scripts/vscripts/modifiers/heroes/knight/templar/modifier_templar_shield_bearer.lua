
if modifier_templar_shield_bearer == nil then
    modifier_templar_shield_bearer = class({})
end

function modifier_templar_shield_bearer:IsHidden()
	return true
end

function modifier_templar_shield_bearer:GetTexture()
    return "dragon_knight_dragon_tail"
end

function modifier_templar_shield_bearer:RemoveOnDeath()
	return false
end

function modifier_templar_shield_bearer:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
    }
    return funcs
end

function modifier_templar_shield_bearer:GetModifierPhysical_ConstantBlock()	
	if RollPercentage(self:GetAbility():GetSpecialValueFor("block_chance")) then
		return self:GetAbility():GetSpecialValueFor("block_dmg") or 0
	end
	return nil
end


