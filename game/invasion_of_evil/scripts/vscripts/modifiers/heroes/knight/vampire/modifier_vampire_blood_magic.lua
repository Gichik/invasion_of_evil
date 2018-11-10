
if modifier_vampire_blood_magic == nil then
    modifier_vampire_blood_magic = class({})
end

function modifier_vampire_blood_magic:IsHidden()
	return true
end

function modifier_vampire_blood_magic:RemoveOnDeath()
	return false
end

function modifier_vampire_blood_magic:IsPurgable()
    return false
end

function modifier_vampire_blood_magic:IsPurgeException()
    return false
end

function modifier_vampire_blood_magic:GetTexture()
    return "ogre_magi_bloodlust"
end

--function modifier_vampire_blood_magic:GetEffectName()
--    return "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf"
--end

function modifier_vampire_blood_magic:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
    return funcs
end


function modifier_vampire_blood_magic:GetModifierConstantHealthRegen()	
	return self:GetAbility():GetSpecialValueFor("reduced_hp_regen") or 0
end

function modifier_vampire_blood_magic:GetModifierMagicalResistanceBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist") or 0
end

function modifier_vampire_blood_magic:GetModifierPhysicalArmorBonus()	
	return self:GetAbility():GetSpecialValueFor("bonus_armor") or 0
end

function modifier_vampire_blood_magic:OnCreated()

end