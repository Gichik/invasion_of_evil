
if modifier_madman_fearless == nil then
    modifier_madman_fearless = class({})
end

function modifier_madman_fearless:IsHidden()
	return false
end

function modifier_madman_fearless:GetTexture()
    return "bristleback_warpath"
end

function modifier_madman_fearless:RemoveOnDeath()
	return false
end

function modifier_madman_fearless:GetEffectName()
    return nil
end

function modifier_madman_fearless:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
    return funcs
end

function modifier_madman_fearless:GetModifierPreAttack_BonusDamage()  
    return self:GetStackCount()  * self:GetAbility():GetSpecialValueFor("dmg_bonus")
end

function modifier_madman_fearless:GetModifierMoveSpeedBonus_Constant()   
    return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("movespeed_bonus")
end

function modifier_madman_fearless:OnDeath(data)
    if IsServer() then
        if self.caster and self.ability and self.dmg and self.dmgRange then
            if not self.caster:IsNull() and not self.ability:IsNull() then

                if data.unit:IsCreature() then
                    if data.attacker == self.caster then

                        ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_bloody_mid.vpcf", PATTACH_ABSORIGIN_FOLLOW, data.unit)
                        data.unit:EmitSound("Hero_PhantomAssassin.CoupDeGrace")


                        local units = FindUnitsInRadius( data.unit:GetTeamNumber(), data.unit:GetAbsOrigin(), self.caster, self.dmgRange,
                            DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

                        if units then   
                            for i = 1, #units do
                                if units[i] then

                                    ApplyDamage({
                                        victim = units[i],
                                        attacker = self.caster,
                                        damage = self.dmg,
                                        damage_type = DAMAGE_TYPE_PHYSICAL,
                                        ability = self.ability,
                                        damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
                                       })

                                end 
                            end
                        end


                    end
                end

            end
        end
    end
end

function modifier_madman_fearless:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.dmgRange = 0
        self.itemCount = 0
        self.dmg = self.caster:GetAverageTrueAttackDamage(self.caster)
        
        if self.ability then 
            self.dmgRange = self.ability:GetSpecialValueFor("dmg_range")           
        end

        self:SetStackCount(0)
        self:StartIntervalThink(0.1) 

    end
end


function modifier_madman_fearless:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.dmgRange = 0
        self.dmg = self.caster:GetAverageTrueAttackDamage(self.caster)
        
        if self.ability then 
            self.dmgRange = self.ability:GetSpecialValueFor("dmg_range")           
        end

        self:SetStackCount(6-self.itemCount)
    end
end


function modifier_madman_fearless:OnIntervalThink()
    if IsServer() then
        if self.caster and self.ability and self.itemCount then
            if not self.caster:IsNull() and not self.ability:IsNull() then
                local item = nil
                self.itemCount = 0
                for i = 0, 5 do
                    item = self.caster:GetItemInSlot(i)
                    if item ~= nil then
                        self.itemCount = self.itemCount + 1
                    end
                end

                self:ForceRefresh()
            end
        end
    end
end