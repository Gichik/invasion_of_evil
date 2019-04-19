
if modifier_elementalist_magic_of_water == nil then
    modifier_elementalist_magic_of_water = class({})
end

function modifier_elementalist_magic_of_water:IsHidden()
	return true
end

function modifier_elementalist_magic_of_water:GetTexture()
    return "invoker_quas"
end

function modifier_elementalist_magic_of_water:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_water:GetEffectName()
    return nil
end

function modifier_elementalist_magic_of_water:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_elementalist_magic_of_water:OnAttackLanded(data)
	if IsServer() then
        if self.debuffChance and self.debuffRadius and self.debuffDur then
            if data.attacker == self:GetParent() and RollPercentage(self.debuffChance) then

                ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_cast.vpcf", PATTACH_ABSORIGIN, data.target)
                data.target:EmitSound("Hero_Morphling.AdaptiveStrikeAgi.Target")

                local units = FindUnitsInRadius( data.attacker:GetTeamNumber(), data.target:GetAbsOrigin(), data.attacker, self.debuffRadius,
                    DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

                local modifier = nil
                for i = 1, #units do
                    if units[i] then
                        modifier = units[i]:FindModifierByName("modifier_elementalist_magic_of_water_debuff")

                        if  not modifier then
                            modifier = units[i]:AddNewModifier(data.attacker, self:GetAbility(), "modifier_elementalist_magic_of_water_debuff", {duration = self.debuffDur})
                        end

                        if modifier:GetStackCount() < self.maxStacks then
                            modifier:IncrementStackCount()
                        end

                        modifier:ForceRefresh()
                    end 
                end
    			
            end
    	end
	end
end

function modifier_elementalist_magic_of_water:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0
        self.debuffRadius = 0 
        self.maxStacks = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")     
            self.debuffRadius = self.ability:GetSpecialValueFor("debuff_radius") 
            self.maxStacks = self.ability:GetSpecialValueFor("max_stacks")  
        end
    end
end


function modifier_elementalist_magic_of_water:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0
        self.debuffRadius = 0 
        self.maxStacks = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")     
            self.debuffRadius = self.ability:GetSpecialValueFor("debuff_radius") 
            self.maxStacks = self.ability:GetSpecialValueFor("max_stacks")  
        end
    end
end

--------------------------------------------------------------------------------

modifier_elementalist_magic_of_water_debuff = class({})

function modifier_elementalist_magic_of_water_debuff:GetTexture()
    return "invoker_quas"
end

function modifier_elementalist_magic_of_water_debuff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_water_debuff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_water_debuff:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_debuff.vpcf"
end


function modifier_elementalist_magic_of_water_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_elementalist_magic_of_water_debuff:GetModifierMagicalResistanceBonus()
    return -self.reduce_resist*self:GetStackCount()
end

function modifier_elementalist_magic_of_water_debuff:OnCreated()    
    self.reduce_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_resist = self.ability:GetSpecialValueFor("reduce_resist")
    end
end

function modifier_elementalist_magic_of_water_debuff:OnRefresh()    
    self.reduce_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_resist = self.ability:GetSpecialValueFor("reduce_resist")
    end
end