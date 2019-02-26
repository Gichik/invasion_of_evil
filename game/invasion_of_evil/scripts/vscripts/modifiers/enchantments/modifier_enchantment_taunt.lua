
if modifier_enchantment_taunt == nil then
    modifier_enchantment_taunt = class({})
end

function modifier_enchantment_taunt:IsHidden()
    return true
end

function modifier_enchantment_taunt:GetTexture()
    return "legion_commander_press_the_attack"
end

function modifier_enchantment_taunt:RemoveOnDeath()
    return true
end

function modifier_enchantment_taunt:DeclareFunctions()
    return nil
end


function modifier_enchantment_taunt:OnCreated(data)
    if IsServer() then
        self.hParent = self:GetParent()
        self.duration = self:GetAbility():GetSpecialValueFor("duration") 
        self.interval = self:GetAbility():GetSpecialValueFor("interval")       
        self.castRange = self:GetAbility():GetCastRange() or 0   
        self:StartIntervalThink(self.interval)
    end 
end

function modifier_enchantment_taunt:OnRefresh()
    if IsServer() then
        self.hParent = self:GetParent()
        self.duration = self:GetAbility():GetSpecialValueFor("duration")        
        self.castRange = self:GetAbility():GetCastRange() or 0    
    end 
end

function modifier_enchantment_taunt:OnIntervalThink()
    if self.hParent then

        --self.hParent:EmitSound("Hero_LegionCommander.PressTheAttack")

        local units = FindUnitsInRadius( self.hParent:GetTeamNumber(), self.hParent:GetAbsOrigin(), self.hParent, self.castRange,
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
        
        if units then
            for i = 1, #units do
                units[i]:AddNewModifier(self.hParent, self, "modifier_enchantment_taunt_debuff", {duration = self.duration})
            end
        end 
    end
end

--------------------------------------------------------------------------------


modifier_enchantment_taunt_debuff = class({})


modifier_name_buff = modifier_enchantment_taunt_debuff

function modifier_name_buff:IsHidden()
	return false
end

function modifier_name_buff:IsDebuff()
    return true
end

function modifier_name_buff:GetTexture()
    return "legion_commander_press_the_attack"
end

function modifier_name_buff:RemoveOnDeath()
	return true
end

function modifier_name_buff:DeclareFunctions()
    return nil
end


function modifier_name_buff:OnCreated(data)
    if IsServer() then
        self:GetParent():SetForceAttackTarget(nil)
        self:GetParent():SetForceAttackTarget(self:GetCaster())
    end
end

function modifier_name_buff:OnRefresh()
    if IsServer() then
        self:GetParent():SetForceAttackTarget(nil)
        self:GetParent():SetForceAttackTarget(self:GetCaster())
    end
end

function modifier_name_buff:OnDestroy()
    if IsServer() then
        self:GetParent():SetForceAttackTarget(nil)
    end
end