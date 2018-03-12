
if modifier_sapient_flows_of_magic == nil then
    modifier_sapient_flows_of_magic = class({})
end

function modifier_sapient_flows_of_magic:GetTexture()
    return "wisp_tether"
end

function modifier_sapient_flows_of_magic:IsHidden()
	return true
end

function modifier_sapient_flows_of_magic:RemoveOnDeath()
	return true
end

function modifier_sapient_flows_of_magic:DeclareFunctions()
    return nil
end

function modifier_sapient_flows_of_magic:CheckState() 
  local state = {
      [MODIFIER_STATE_ROOTED] = true,
  }
  return state
end

--[[function modifier_sapient_flows_of_magic:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_UNIT_MOVED
    }
    return funcs
end

function modifier_sapient_flows_of_magic:OnUnitMoved(data)	
	if IsServer() then
		if data.unit == self:GetParent() then
			self:Destroy()
		end
	end
end]]

function modifier_sapient_flows_of_magic:IsAura()
    return true
end

function modifier_sapient_flows_of_magic:GetModifierAura()
    return "modifier_sapient_flows_of_magic_buff"
end

function modifier_sapient_flows_of_magic:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("aura_radius")
    
end

function modifier_sapient_flows_of_magic:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_sapient_flows_of_magic:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sapient_flows_of_magic:GetAuraDuration()
    return self.auraDuration or 0
end

function modifier_sapient_flows_of_magic:OnCreated(data)
    self.auraDuration = 0.3
    if IsServer() then
        if self:GetParent() then
            ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_ghostship_marker_ripple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        end
        self:StartIntervalThink(3)
    end
end

function modifier_sapient_flows_of_magic:OnIntervalThink()
    if self:GetParent() then
        ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_ghostship_marker_ripple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

--------------------------------------------------------------------------------

modifier_sapient_flows_of_magic_buff = class({})

function modifier_sapient_flows_of_magic_buff:IsHidden()
	return true
end

function modifier_sapient_flows_of_magic_buff:GetTexture()
    return "wisp_tether"
end

function modifier_sapient_flows_of_magic_buff:RemoveOnDeath()
	return true
end

function modifier_sapient_flows_of_magic_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_sapient_flows_of_magic_buff:GetEffectName()
    return "particles/items_fx/healing_clarity_c.vpcf"
end

function modifier_sapient_flows_of_magic_buff:GetModifierConstantManaRegen()
    if IsServer() then
    	if self:GetCaster() then
        	self.hp_regen = self:GetCaster():FindAbilityByName("sapient_flows_of_magic")
        	if self.hp_regen then
        		self.hp_regen = self.hp_regen:GetSpecialValueFor("bonus_mp_regen") or 0
        		self:SetStackCount(self.hp_regen)
        	end
    	end
    end	
	return self:GetStackCount() or 0
end

function modifier_sapient_flows_of_magic_buff:OnCreated()
    if IsServer() then
        if self:GetParent() ~= self:GetCaster() then
        	self.ability = self:GetCaster():FindAbilityByName("sapient_flows_of_life")
            self:GetParent():AddNewModifier(self:GetCaster(), self.ability, "modifier_sapient_flows_of_magic_lore", {})
        end
    end
end

function modifier_sapient_flows_of_magic_buff:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveModifierByName("modifier_sapient_flows_of_magic_lore")
    end
end
--------------------------------------------------------------------------------

modifier_sapient_flows_of_magic_lore = class({})

function modifier_sapient_flows_of_magic_lore:GetTexture()
    return "wisp_tether"
end

function modifier_sapient_flows_of_magic_lore:IsHidden()
    return false
end

function modifier_sapient_flows_of_magic_lore:RemoveOnDeath()
    return true
end