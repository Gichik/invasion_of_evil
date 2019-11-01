
if modifier_madman_contiguous == nil then
    modifier_madman_contiguous = class({})
end

function modifier_madman_contiguous:IsHidden()
	return true
end

function modifier_madman_contiguous:GetTexture()
    return "terrorblade_reflection"
end

function modifier_madman_contiguous:RemoveOnDeath()
	return false
end

function modifier_madman_contiguous:GetEffectName()
    return nil
end

function modifier_madman_contiguous:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_madman_contiguous:OnAttackLanded(data)
	if IsServer() then
        if self.caster and self.buffDur then
            if data.attacker == self.caster then
                --data.target:EmitSound("Hero_Jakiro.LiquidFire")
                self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_madman_contiguous_buff", {duration = self.buffDur})
            end
    	end
	end
end

function modifier_madman_contiguous:OnCreated()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffDur = 0 

        if self.ability then
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")       
        end
    end
end


function modifier_madman_contiguous:OnRefresh()
    if IsServer() then
        --print("OnCreated")
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.buffDur = 0 

        if self.ability then 
            self.buffDur = self.ability:GetSpecialValueFor("buff_duration")       
        end
    end
end

--------------------------------------------------------------------------------

modifier_madman_contiguous_buff = class({})

function modifier_madman_contiguous_buff:GetTexture()
    return "terrorblade_reflection"
end

function modifier_madman_contiguous_buff:IsHidden()
    return false
end

function modifier_madman_contiguous_buff:RemoveOnDeath()
    return true
end

--function modifier_madman_contiguous_buff:GetEffectName()
--    return "particles/econ/items/pangolier/pangolier_ti8_immortal/pangolier_ti8_immortal_shield_buff.vpcf"
--end

function modifier_madman_contiguous_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_madman_contiguous_buff:GetModifierPhysicalArmorBonus()
    return self.ability:GetSpecialValueFor("bonus_armor")
end

function modifier_madman_contiguous_buff:OnCreated()    
    self.ability = self:GetAbility()
end

function modifier_madman_contiguous_buff:OnRefresh()    
    self.ability = self:GetAbility()
end
