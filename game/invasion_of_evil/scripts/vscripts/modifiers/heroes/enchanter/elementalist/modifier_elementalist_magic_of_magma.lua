
if modifier_elementalist_magic_of_magma == nil then
    modifier_elementalist_magic_of_magma = class({})
end

function modifier_elementalist_magic_of_magma:IsHidden()
	return true
end

function modifier_elementalist_magic_of_magma:GetTexture()
    return "phoenix_supernova"
end

function modifier_elementalist_magic_of_magma:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_magma:IsPurgable()
    return false
end

function modifier_elementalist_magic_of_magma:IsPurgeException()
    return false
end

function modifier_elementalist_magic_of_magma:DeclareFunctions()
    return nil
end

function modifier_elementalist_magic_of_magma:IsAura()
    return true
end

function modifier_elementalist_magic_of_magma:GetModifierAura()
    return "modifier_elementalist_magic_of_magma_debuff"
end


function modifier_elementalist_magic_of_magma:GetAuraRadius()
    return self:GetAbility():GetCastRange()
end

function modifier_elementalist_magic_of_magma:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_elementalist_magic_of_magma:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_elementalist_magic_of_magma:GetAuraEntityReject(target)
    return false
end

function modifier_elementalist_magic_of_magma:GetAuraDuration()
    return 0.5
end


--------------------------------------------------------------------------------

modifier_elementalist_magic_of_magma_debuff = class({})

function modifier_elementalist_magic_of_magma_debuff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_magma_debuff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_magma_debuff:GetTexture()
    return "phoenix_supernova"
end

function modifier_elementalist_magic_of_magma_debuff:GetEffectName()
    --return "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf"
    return nil
end

function modifier_elementalist_magic_of_magma_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_elementalist_magic_of_magma_debuff:GetModifierPreAttack_BonusDamage()  
    return -self.reduce_dmg
end

function modifier_elementalist_magic_of_magma_debuff:OnCreated()    
    self.reduce_dmg = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_dmg = self.ability:GetSpecialValueFor("reduce_dmg")
    end
end

function modifier_elementalist_magic_of_magma_debuff:OnRefresh()    
    self.reduce_dmg = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_dmg = self.ability:GetSpecialValueFor("reduce_dmg")
    end
end
