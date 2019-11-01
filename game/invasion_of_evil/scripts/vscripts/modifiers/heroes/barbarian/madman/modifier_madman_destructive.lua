
if modifier_madman_destructive == nil then
    modifier_madman_destructive = class({})
end

function modifier_madman_destructive:IsHidden()
    return true
end

function modifier_madman_destructive:GetTexture()
    return "slardar_amplify_damage"
end

function modifier_madman_destructive:RemoveOnDeath()
    return false
end

function modifier_madman_destructive:GetEffectName()
    return nil
end

function modifier_madman_destructive:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_madman_destructive:OnAttackLanded(data)
    if IsServer() then
        if self.debuffChance and self.debuffDur then
            if data.attacker == self:GetParent() and RollPercentage(self.debuffChance) then
                
                local modifier = data.target:FindModifierByName("modifier_madman_destructive_debuff")

                if not modifier then
                    if self.maxStacks == 1 then
                        data.attacker:EmitSound("brewmaster_brew_laugh_01")
                    end
                    modifier = data.target:AddNewModifier(data.attacker, self:GetAbility(), "modifier_madman_destructive_debuff", {duration = self.debuffDur})
                end

                if modifier:GetStackCount() < self.maxStacks then
                    modifier:IncrementStackCount()
                end
                
            end
        end
    end
end

function modifier_madman_destructive:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0 
        self.maxStacks = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")     
            self.maxStacks = self.ability:GetSpecialValueFor("max_stacks")  
        end
    end
end


function modifier_madman_destructive:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0 
        self.maxStacks = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")      
            self.maxStacks = self.ability:GetSpecialValueFor("max_stacks")  
        end
    end
end

--------------------------------------------------------------------------------

modifier_madman_destructive_debuff = class({})

function modifier_madman_destructive_debuff:GetTexture()
    return "slardar_amplify_damage"
end

function modifier_madman_destructive_debuff:IsHidden()
    return false
end

function modifier_madman_destructive_debuff:RemoveOnDeath()
    return true
end

function modifier_madman_destructive_debuff:GetEffectName()
    return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end


function modifier_madman_destructive_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_madman_destructive_debuff:GetModifierPhysicalArmorBonus()
    return -self:GetAbility():GetSpecialValueFor("reduce_armor")*self:GetStackCount()
end
