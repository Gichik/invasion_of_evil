
if modifier_berserk_know_anc == nil then
    modifier_berserk_know_anc = class({})
end

function modifier_berserk_know_anc:IsHidden()
	return true
end

function modifier_berserk_know_anc:GetTexture()
    return "lone_druid_true_form_druid"
end

function modifier_berserk_know_anc:RemoveOnDeath()
	return true
end

function modifier_berserk_know_anc:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_berserk_know_anc:GetModifierMagicalResistanceBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist")
end

