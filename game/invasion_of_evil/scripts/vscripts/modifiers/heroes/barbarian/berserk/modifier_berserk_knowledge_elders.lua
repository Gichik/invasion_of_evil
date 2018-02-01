
if modifier_berserk_knowledge_elders == nil then
    modifier_berserk_knowledge_elders = class({})
end

function modifier_berserk_knowledge_elders:IsHidden()
	return true
end

function modifier_berserk_knowledge_elders:GetTexture()
    return "lone_druid_true_form_druid"
end

function modifier_berserk_knowledge_elders:RemoveOnDeath()
	return true
end

function modifier_berserk_knowledge_elders:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_berserk_knowledge_elders:GetModifierMagicalResistanceBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist")
end

