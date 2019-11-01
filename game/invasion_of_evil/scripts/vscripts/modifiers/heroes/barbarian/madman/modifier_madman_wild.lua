
if modifier_madman_wild == nil then
    modifier_madman_wild = class({})
end

function modifier_madman_wild:IsHidden()
	return false
end

function modifier_madman_wild:GetTexture()
    return "lycan_feral_impulse"
end

function modifier_madman_wild:RemoveOnDeath()
	return false
end

function modifier_madman_wild:GetEffectName()
    return nil
end

function modifier_madman_wild:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH
    }
    return funcs
end

function modifier_madman_wild:OnDeath(data)
	if IsServer() then
        if self.caster and self.buffDur then
            if data.attacker == self.caster then

                self:IncrementStackCount()

                if self:GetStackCount() >= self.stackForBuf then
                    self:SetStackCount(0)
                    --self.caster:EmitSound("Hero_TrollWarlord.BattleTrance.Cast")
                    --ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf", PATTACH_ABSORIGIN, self.caster)
                    self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_madman_wild_buff", {duration = self.buffDur})
                end

            end
    	end
	end
end

function modifier_madman_wild:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffDur = 0
        self.stackForBuf = 0
            
        if self.ability then
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")  
            self.stackForBuf = self.ability:GetSpecialValueFor("stack_for_buff")      
        end
    end
end


function modifier_madman_wild:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffDur = 0 
        self.stackForBuf = 0

        if self.ability then
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")  
            self.stackForBuf = self.ability:GetSpecialValueFor("stack_for_buff")      
        end
    end
end

--------------------------------------------------------------------------------

modifier_madman_wild_buff = class({})

function modifier_madman_wild_buff:IsHidden()
    return false
end

function modifier_madman_wild_buff:GetTexture()
    return "lycan_shapeshift"
end

function modifier_madman_wild_buff:RemoveOnDeath()
    return true
end

function modifier_madman_wild_buff:GetEffectName()
    return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end

function modifier_madman_wild_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_madman_wild_buff:OnAttackLanded(data)
    if IsServer() then
        if data.attacker == self:GetParent() then
            local parent = self:GetParent()
            --print(data.damage*self:GetAbility():GetSpecialValueFor("lifesteal_perc")/100)
            parent:Heal(data.damage*self:GetAbility():GetSpecialValueFor("lifesteal_perc")/100,parent)
        end
    end
end
