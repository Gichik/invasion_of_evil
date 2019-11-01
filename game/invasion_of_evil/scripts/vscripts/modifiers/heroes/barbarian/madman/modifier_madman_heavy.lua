
if modifier_madman_heavy == nil then
    modifier_madman_heavy = class({})
end

function modifier_madman_heavy:IsHidden()
	return true
end

function modifier_madman_heavy:GetTexture()
    return "ember_spirit_sleight_of_fist"
end

function modifier_madman_heavy:RemoveOnDeath()
	return false
end

function modifier_madman_heavy:GetEffectName()
    return nil
end

function modifier_madman_heavy:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_MISS_PERCENTAGE
    }
    return funcs
end

function modifier_madman_heavy:OnAttackLanded(data)
	if IsServer() then
        if self.caster and self.stunDur then
            if data.attacker == self.caster then
                --data.target:EmitSound("Hero_Jakiro.LiquidFire")
                data.target:AddNewModifier(self.caster, self:GetAbility(), "modifier_stunned", {duration = self.stunDur})
            end
    	end
	end
end

function modifier_madman_heavy:GetModifierMiss_Percentage()
    return self:GetAbility():GetSpecialValueFor("miss_perc") or 0
end

function modifier_madman_heavy:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.stunDur = 0 

        if self.ability then
            self.stunDur = self.ability:GetSpecialValueFor("stun_duration")       
        end
    end
end


function modifier_madman_heavy:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.stunDur = 0 

        if self.ability then
            self.stunDur = self.ability:GetSpecialValueFor("stun_duration")       
        end
    end
end

