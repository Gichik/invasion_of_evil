
if modifier_madman_bloodthirsty == nil then
    modifier_madman_bloodthirsty = class({})
end

function modifier_madman_bloodthirsty:IsHidden()
	return true
end

function modifier_madman_bloodthirsty:GetTexture()
    return "bloodseeker_rupture"
end

function modifier_madman_bloodthirsty:RemoveOnDeath()
	return false
end

function modifier_madman_bloodthirsty:GetEffectName()
    return nil
end

function modifier_madman_bloodthirsty:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_madman_bloodthirsty:OnAttackLanded(data)
	if IsServer() then
        if self.debuffChance and self.debuffDur then
            if data.attacker == self:GetParent() and RollPercentage(self.debuffChance) then

                ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_drops_b.vpcf", PATTACH_ABSORIGIN, data.target)
                data.target:EmitSound("Hero_LifeStealer.OpenWounds")

                data.target:AddNewModifier(data.attacker, self:GetAbility(), "modifier_madman_bloodthirsty_debuff", {duration = self.debuffDur})

            end
    	end
	end
end

function modifier_madman_bloodthirsty:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")       
        end
    end
end


function modifier_madman_bloodthirsty:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.debuffChance = 0
        self.debuffDur = 0

        if self.ability then
            self.debuffChance = self.ability:GetSpecialValueFor("debuff_chance") 
            self.debuffDur = self.ability:GetSpecialValueFor("debuff_duration")       
        end
    end
end


----------------------------------------------------------------------------------------
modifier_madman_bloodthirsty_debuff = class({})


function modifier_madman_bloodthirsty_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_madman_bloodthirsty_debuff:GetEffectName()
    return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner_ground.vpcf"
end


function modifier_madman_bloodthirsty_debuff:IsHidden()
    return false
end

function modifier_madman_bloodthirsty_debuff:GetTexture()
    return "bloodseeker_rupture"
end

function modifier_madman_bloodthirsty_debuff:GetModifierMoveSpeedBonus_Constant()
    if self.reduce_ms then
        return -self.reduce_ms
    end
    return 0
end


function modifier_madman_bloodthirsty_debuff:OnCreated()
    if IsServer() then
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.interval = 0 
        self.reduce_ms = 0
        self.convPerc = 0
        self.dmg = 0

        if self.ability then
            self.interval = self.ability:GetSpecialValueFor("damage_interval") 
            self.reduce_ms = self.ability:GetSpecialValueFor("reduce_ms")          
        end


        if self.interval then
            self:StartIntervalThink(self.interval) 
        end

    end
end

function modifier_madman_bloodthirsty_debuff:OnIntervalThink()
    local hAttacker = self:GetParent()
    local hAbility = self

    if self.caster and self.ability then
        if not self.caster:IsNull() and not self.ability:IsNull() then
            self.convPerc = self.ability:GetSpecialValueFor("debuff_damage_perc")
            self.dmg = self.caster:GetAverageTrueAttackDamage(self:GetParent()) * self.convPerc/100
            hAttacker = self.caster
            hAbility = self.ability
        end
    end

    
    ApplyDamage({
        victim = self:GetParent(),
        attacker = hAttacker,
        damage = self.dmg,
        damage_type = DAMAGE_TYPE_PHYSICAL,
        ability = hAbility,
        damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
       })
    
end