modifier_strychnine = class({})

function modifier_strychnine:GetTexture()
    return "venomancer_poison_sting"
end

function modifier_strychnine:IsHidden()
    return false
end

function modifier_strychnine:RemoveOnDeath()
    return true
end

function modifier_strychnine:OnCreated(data)
    if IsServer() then
        self:StartIntervalThink(1.0) 
        self.poisonDmg = data.poisonDmg
        self.attacker = self:GetCaster() or nil
    end
end

function modifier_strychnine:OnIntervalThink()
    self.attacker = self:GetCaster() or nil
    ApplyDamage({
        victim = self:GetParent(),
        attacker = self.attacker,
        damage = self.poisonDmg * self:GetStackCount(),
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self
       })
end