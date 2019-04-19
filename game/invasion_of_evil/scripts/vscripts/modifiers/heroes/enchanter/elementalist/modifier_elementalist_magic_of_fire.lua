
if modifier_elementalist_magic_of_fire == nil then
    modifier_elementalist_magic_of_fire = class({})
end

function modifier_elementalist_magic_of_fire:IsHidden()
	return true
end

function modifier_elementalist_magic_of_fire:GetTexture()
    return "invoker_exort"
end

function modifier_elementalist_magic_of_fire:RemoveOnDeath()
	return false
end

function modifier_elementalist_magic_of_fire:GetEffectName()
    return nil
end

function modifier_elementalist_magic_of_fire:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_elementalist_magic_of_fire:OnAttackLanded(data)
	if IsServer() then
        if self.debuffChance and self.debuffRadius and self.debuffDur then
            if data.attacker == self:GetParent() and RollPercentage(self.debuffChance) then

                ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", PATTACH_ABSORIGIN, data.target)
                data.target:EmitSound("Hero_Jakiro.LiquidFire")

                local units = FindUnitsInRadius( data.attacker:GetTeamNumber(), data.target:GetAbsOrigin(), data.attacker, self.debuffRadius,
                    DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

                for i = 1, #units do
                    if units[i] then
                        units[i]:AddNewModifier(data.attacker, self:GetAbility(), "modifier_elementalist_magic_of_fire_debuff", {duration = self.debuffDur})
                    end 
                end
    			
            end
    	end
	end
end

function modifier_elementalist_magic_of_fire:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0
        self.debuffRadius = 0 

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")     
            self.debuffRadius = self.ability:GetSpecialValueFor("debuff_radius")  
        end
    end
end


function modifier_elementalist_magic_of_fire:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0
        self.debuffRadius = 0 

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")     
            self.debuffRadius = self.ability:GetSpecialValueFor("debuff_radius")  
        end
    end
end

--------------------------------------------------------------------------------

modifier_elementalist_magic_of_fire_debuff = class({})

function modifier_elementalist_magic_of_fire_debuff:GetTexture()
    return "invoker_exort"
end

function modifier_elementalist_magic_of_fire_debuff:IsHidden()
    return false
end

function modifier_elementalist_magic_of_fire_debuff:RemoveOnDeath()
    return true
end

function modifier_elementalist_magic_of_fire_debuff:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end


function modifier_elementalist_magic_of_fire_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function modifier_elementalist_magic_of_fire_debuff:GetModifierMagicalResistanceBonus()
    return self.reduce_resist
end


function modifier_elementalist_magic_of_fire_debuff:OnCreated()    
    self.reduce_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_resist = self.ability:GetSpecialValueFor("reduce_resist")
    end
end

function modifier_elementalist_magic_of_fire_debuff:OnRefresh()    
    self.reduce_resist = 0
    self.ability = self:GetAbility()

    if not self.ability:IsNull() then
        self.reduce_resist = self.ability:GetSpecialValueFor("reduce_resist")
    end
end
