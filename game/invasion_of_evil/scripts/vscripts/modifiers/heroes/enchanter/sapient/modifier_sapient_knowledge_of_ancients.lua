
if modifier_sapient_knowledge_of_ancients == nil then
    modifier_sapient_knowledge_of_ancients = class({})
end

function modifier_sapient_knowledge_of_ancients:IsHidden()
	return true
end

function modifier_sapient_knowledge_of_ancients:GetTexture()
    return "oracle_fates_edict"
end

function modifier_sapient_knowledge_of_ancients:RemoveOnDeath()
	return true
end

function modifier_sapient_knowledge_of_ancients:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_sapient_knowledge_of_ancients:GetModifierPreAttack_BonusDamage()	
	return self:GetParent():GetMaxMana()*self:GetAbility():GetSpecialValueFor("mana_dmg_perc")/100 or 0
end