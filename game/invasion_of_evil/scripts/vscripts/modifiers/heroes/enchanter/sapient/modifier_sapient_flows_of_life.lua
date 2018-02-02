
if modifier_sapient_flows_of_life == nil then
    modifier_sapient_flows_of_life = class({})
end

function modifier_sapient_flows_of_life:GetTexture()
    return "dazzle_shadow_wave"
end

function modifier_sapient_flows_of_life:IsHidden()
	return true
end

function modifier_sapient_flows_of_life:RemoveOnDeath()
	return true
end

function modifier_sapient_flows_of_life:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_UNIT_MOVED
    }
    return funcs
end

function modifier_sapient_flows_of_life:OnUnitMoved(data)	
	if IsServer() then
		if data.unit == self:GetParent() then
			self:Destroy()
		end
	end
end

function modifier_sapient_flows_of_life:IsAura()
    return true
end

function modifier_sapient_flows_of_life:GetModifierAura()
    return "modifier_sapient_flows_of_life_buff"
end

function modifier_sapient_flows_of_life:GetEffectName()
    return "particles/units/heroes/hero_necrolyte/necrolyte_spirit_ground_aura.vpcf"
end


function modifier_sapient_flows_of_life:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("aura_radius") or 0
    
end

function modifier_sapient_flows_of_life:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_sapient_flows_of_life:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sapient_flows_of_life:GetAuraDuration()
    return self.auraDuration
end

function modifier_sapient_flows_of_life:OnCreated(data)
    self.auraDuration = 0.3
end

--------------------------------------------------------------------------------

modifier_sapient_flows_of_life_buff = class({})

function modifier_sapient_flows_of_life_buff:IsHidden()
	return true
end

function modifier_sapient_flows_of_life_buff:GetTexture()
    return "dazzle_shadow_wave"
end

function modifier_sapient_flows_of_life_buff:RemoveOnDeath()
	return true
end

function modifier_sapient_flows_of_life_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_sapient_flows_of_life_buff:GetEffectName()
    return "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal_flame.vpcf"
end

function modifier_sapient_flows_of_life_buff:GetModifierConstantHealthRegen()
    if IsServer() then
    	if self:GetCaster() then
        	self.hp_regen = self:GetCaster():FindAbilityByName("sapient_flows_of_life")
        	if self.hp_regen then
        		self.hp_regen = self.hp_regen:GetSpecialValueFor("bonus_hp_regen") or 0
        		self:SetStackCount(self.hp_regen)
        	end
    	end
    end	
	return self:GetStackCount() or 0
end

function modifier_sapient_flows_of_life_buff:OnCreated()
    if IsServer() then
        if self:GetParent() ~= self:GetCaster() then
        	self.ability = self:GetCaster():FindAbilityByName("sapient_flows_of_life")
            self:GetParent():AddNewModifier(self:GetCaster(), self.ability, "modifier_sapient_flows_of_life_lore", {})
        end
    end
end

function modifier_sapient_flows_of_life_buff:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveModifierByName("modifier_sapient_flows_of_life_lore")
    end
end
--------------------------------------------------------------------------------

modifier_sapient_flows_of_life_lore = class({})

function modifier_sapient_flows_of_life_lore:GetTexture()
    return "dazzle_shadow_wave"
end

function modifier_sapient_flows_of_life_lore:IsHidden()
    return false
end

function modifier_sapient_flows_of_life_lore:RemoveOnDeath()
    return true
end