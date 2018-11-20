
if modifier_vampire_aura_of_death == nil then
    modifier_vampire_aura_of_death = class({})
end

function modifier_vampire_aura_of_death:IsHidden()
	return true
end

function modifier_vampire_aura_of_death:RemoveOnDeath()
	return false
end

function modifier_vampire_aura_of_death:IsPurgable()
    return false
end

function modifier_vampire_aura_of_death:IsPurgeException()
    return false
end

function modifier_vampire_aura_of_death:GetTexture()
    return "shadow_demon_demonic_purge"
end

function modifier_vampire_aura_of_death:GetEffectName()
    return "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf"
end

function modifier_vampire_aura_of_death:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end


function modifier_vampire_aura_of_death:GetModifierConstantHealthRegen()	
	return self:GetAbility():GetSpecialValueFor("reduced_hp_regen") or 0
end

function modifier_vampire_aura_of_death:OnCreated()
    if IsServer() then
        self.hCaster = self:GetCaster() or nil
        self.radius = self:GetAbility():GetCastRange() or 0
        self:StartIntervalThink(1.0) 
    end
end

function modifier_vampire_aura_of_death:OnIntervalThink()
    if self.hCaster then
        local units = FindUnitsInRadius( self.hCaster:GetTeamNumber(), self.hCaster:GetAbsOrigin(), self.hCaster, self.radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
        
        local dmg = self:GetAbility():GetSpecialValueFor("damage") or 0

        if units then
            for i = 1, #units do
                ApplyDamage({
                    victim = units[i],
                    attacker = self.hCaster,
                    damage = dmg,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = self
                   })
            end
        end

    end
end