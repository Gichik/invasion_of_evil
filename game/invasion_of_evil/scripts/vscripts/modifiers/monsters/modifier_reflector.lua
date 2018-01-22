
if modifier_reflector == nil then
    modifier_reflector = class({})
end

function modifier_reflector:IsHidden()
	return false
end

function modifier_reflector:GetTexture()
    return "nevermore_shadowraze1"
end

function modifier_reflector:RemoveOnDeath()
	return true
end

function modifier_reflector:CanBeAddToMinions()
    return true
end

function modifier_reflector:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

function modifier_reflector:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
	        ApplyDamage({
	            victim = data.attacker,
	            attacker = self:GetParent(),
	            damage = data.damage*self.refPercent/100,
	            damage_type = DAMAGE_TYPE_PURE,
	            ability = self
	           })
	        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf", PATTACH_POINT_FOLLOW, data.attacker) 
			ParticleManager:SetParticleControlEnt(particle, 0, data.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", data.unit:GetAbsOrigin(), true) 
			ParticleManager:SetParticleControlEnt(particle, 1, data.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", data.attacker:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
		end
	end
end

function modifier_reflector:OnCreated()
	if IsServer() then
		self.refPercent = 80
		self:GetParent():SetRenderColor(220, 20, 60) 
	end
end