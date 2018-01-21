
if modifier_giant == nil then
    modifier_giant = class({})
end

function modifier_giant:IsHidden()
	return false
end

function modifier_giant:GetTexture()
    return "beastmaster_primal_roar"
end

function modifier_giant:RemoveOnDeath()
	return true
end

function modifier_giant:CanBeAddToMinions()
    return true
end

function modifier_giant:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
    return funcs
end

function modifier_giant:GetModifierPreAttack_BonusDamage()	
	return self.damageBonus
end

function modifier_giant:GetModifierExtraHealthBonus()	
	return self.healthBonus
end

function modifier_giant:GetModifierModelScale()	
	return self.modelScalePerc
end

function modifier_giant:OnCreated()
	self.damageBonus = self:GetParent():GetLevel()*50
	self.healthBonus = self:GetParent():GetLevel()*100
	self.modelScalePerc = 60

	if IsServer() then
		self:GetParent():SetRenderColor(255, 165, 0)
	end
end

function modifier_giant:OnDestroy()
	if IsServer() then

	end
end


