
if modifier_replacement_of_organs == nil then
    modifier_replacement_of_organs = class({})
end

function modifier_replacement_of_organs:IsHidden()
    return false
end

function modifier_replacement_of_organs:RemoveOnDeath()
    return true
end

function modifier_replacement_of_organs:CanBeAddToMinions()
    return true
end

function modifier_replacement_of_organs:GetTexture()
    return "item_heart"
end

--function modifier_replacement_of_organs:GetEffectName()
--    return "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf"
--end

function modifier_replacement_of_organs:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_replacement_of_organs:GetModifierConstantHealthRegen()    
    return self.healthRegen*self:GetStackCount() or 0
end

function modifier_replacement_of_organs:GetModifierMagicalResistanceBonus() 
    return self.magicResBonus*(4-self:GetStackCount()) or 0
end

function modifier_replacement_of_organs:GetModifierPhysicalArmorBonus() 
    return self.physArmorBonus*(4-self:GetStackCount()) or 0
end

function modifier_replacement_of_organs:OnCreated()

    self.healthRegen = 15
    self.magicResBonus = 18 
    self.physArmorBonus = 18

    self.auraRadius = 2500
    self.auraDuration = 0.3

    self:SetStackCount(4)

end

function modifier_replacement_of_organs:IsAura()
    return true
end

function modifier_replacement_of_organs:GetAuraRadius()
    return self.auraRadius
end

function modifier_replacement_of_organs:GetModifierAura()
    return "modifier_replacement_of_organs_mark"
end

function modifier_replacement_of_organs:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_replacement_of_organs:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_replacement_of_organs:GetAuraDuration()
    return self.auraDuration
end

function modifier_replacement_of_organs:GetAuraEntityReject(target)

    if (target:GetUnitName() == "npc_jeepers_minion") then
        return false
    end
       
    return true
end

--------------------------------------------------------------------------------

modifier_replacement_of_organs_mark = class({})

function modifier_replacement_of_organs_mark:IsHidden()
    return true
end

function modifier_replacement_of_organs_mark:RemoveOnDeath()
    return true
end

function modifier_replacement_of_organs_mark:OnCreated()
    self.auraRadius = 2500
end

function modifier_replacement_of_organs_mark:OnDestroy()
    if IsServer() then
        local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent(), self.auraRadius,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
            
        if units then
            --EmitSoundOn("Hero_Axe.CounterHelix", caster)  
            for i = 1, #units do    
            local modifier = units[i]:FindModifierByName("modifier_replacement_of_organs")
                if modifier and modifier:GetStackCount() > 0 then
                    modifier:DecrementStackCount()
                end     
            end
        end     
    end
end