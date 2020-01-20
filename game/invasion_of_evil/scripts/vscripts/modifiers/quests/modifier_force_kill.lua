

modifier_force_kill = class({})


function modifier_force_kill:DeclareFunctions()
    return nil
end

function modifier_force_kill:GetTexture()
    return "warlock_upheaval"
end

function modifier_force_kill:IsHidden()
    return true
end

function modifier_force_kill:RemoveOnDeath()
    return true
end

function modifier_force_kill:OnCreated(data)
    self.parent = self:GetParent()
end

function modifier_force_kill:OnDestroy(data)
    if IsServer() and self.parent then
        self.parent:ForceKill(false)
    end
end
