
if modifier_madman_spitfire == nil then
    modifier_madman_spitfire = class({})
end

function modifier_madman_spitfire:IsHidden()
	return true
end

function modifier_madman_spitfire:GetTexture()
    return "huskar_berserkers_blood"
end

function modifier_madman_spitfire:RemoveOnDeath()
	return false
end

function modifier_madman_spitfire:GetEffectName()
    return nil
end

function modifier_madman_spitfire:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_madman_spitfire:OnAttackLanded(data)
	if IsServer() then
        if self.caster and self.buffChance and self.buffDur then
            if data.attacker == self.caster and RollPercentage(self.buffChance) then
                --data.target:EmitSound("Hero_Jakiro.LiquidFire")
                self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_madman_spitfire_buff", {duration = self.buffDur})
            end
    	end
	end
end

function modifier_madman_spitfire:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffChance = 0
        self.buffDur = 0 

        if self.ability then
            self.buffChance = self.ability:GetSpecialValueFor("buff_chance") 
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")       
        end
    end
end


function modifier_madman_spitfire:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffChance = 0
        self.buffDur = 0 

        if self.ability then
            self.buffChance = self.ability:GetSpecialValueFor("buff_chance") 
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")       
        end
    end
end

--------------------------------------------------------------------------------

modifier_madman_spitfire_buff = class({})

function modifier_madman_spitfire_buff:GetTexture()
    return "huskar_berserkers_blood"
end

function modifier_madman_spitfire_buff:IsHidden()
    return false
end

function modifier_madman_spitfire_buff:RemoveOnDeath()
    return true
end

function modifier_madman_spitfire_buff:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_madman_spitfire_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_madman_spitfire_buff:GetModifierAttackSpeedBonus_Constant()
    return self.ability:GetSpecialValueFor("bonus_attack_speed")
end

function modifier_madman_spitfire_buff:OnCreated()    
    self.ability = self:GetAbility()
end

function modifier_madman_spitfire_buff:OnRefresh()    
    self.ability = self:GetAbility()
end
