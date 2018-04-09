
if modifier_berserk_durability == nil then
    modifier_berserk_durability = class({})
end

function modifier_berserk_durability:IsHidden()
	return true
end

function modifier_berserk_durability:GetTexture()
    return "shadow_demon_shadow_poison_release"
end

function modifier_berserk_durability:RemoveOnDeath()
	return false
end

function modifier_berserk_durability:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
    }
    return funcs
end

function modifier_berserk_durability:GetModifierExtraHealthBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

