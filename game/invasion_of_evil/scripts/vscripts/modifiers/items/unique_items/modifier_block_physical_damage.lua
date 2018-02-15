
if modifier_block_physical_damage == nil then
    modifier_block_physical_damage = class({})
end

function modifier_block_physical_damage:IsHidden()
	return true
end

function modifier_block_physical_damage:GetTexture()
    return "dragon_knight_dragon_tail"
end

function modifier_block_physical_damage:RemoveOnDeath()
	return true
end

function modifier_block_physical_damage:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
    }
    return funcs
end

function modifier_block_physical_damage:GetModifierPhysical_ConstantBlock()	
	if RollPercentage(self:GetAbility():GetSpecialValueFor("block_chance")) then
		return self:GetAbility():GetSpecialValueFor("block_dmg") or 0
	end
	return nil
end


