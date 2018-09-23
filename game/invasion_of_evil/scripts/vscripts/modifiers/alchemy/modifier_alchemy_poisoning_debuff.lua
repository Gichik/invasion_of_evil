
modifier_alchemy_poisoning_debuff = class({})

function modifier_alchemy_poisoning_debuff:GetTexture()
    return "venomancer_poison_sting"
end

function modifier_alchemy_poisoning_debuff:IsHidden()
    return false
end

function modifier_alchemy_poisoning_debuff:IsDebuff()
    return true
end

function modifier_alchemy_poisoning_debuff:RemoveOnDeath()
    return true
end

function modifier_alchemy_poisoning_debuff:OnCreated(data)
    if IsServer() then
        self:StartIntervalThink(1.0) 
    end
end

function modifier_alchemy_poisoning_debuff:OnIntervalThink()
    if self:GetParent() then
        local caster = self:GetParent()
        ApplyDamage({
            victim = caster,
            attacker = caster,
            damage = 7,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
           })
    end 
end


