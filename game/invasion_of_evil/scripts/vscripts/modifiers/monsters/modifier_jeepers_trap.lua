
if modifier_jeepers_trap == nil then
    modifier_jeepers_trap = class({})
end

function modifier_jeepers_trap:IsHidden()
	return true
end

function modifier_jeepers_trap:GetTexture()
    return "nevermore_dark_lord"
end

function modifier_jeepers_trap:RemoveOnDeath()
	return true
end

function modifier_jeepers_trap:DeclareFunctions()
    return nil
end

function modifier_jeepers_trap:OnCreated()
	self.caster = self:GetCaster()

	if IsServer() then
		self:StartIntervalThink(1.0) 
	end
end

function modifier_jeepers_trap:OnIntervalThink()
	if self:GetCaster() and self.caster then
		local units = FindUnitsInRadius( self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), self.caster, 150,
				DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
				
		if units[ 1 ] then 
			units[ 1 ]:AddNewModifier(self.caster, nil, "modifier_jeepers_trap_debuff", {duration = 3})
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			EmitSoundOn("DOTA_Item.Maim", units[ 1 ])
			self.caster:ForceKill(false)
		end 
		           
	end
end


--------------------------------------------------------

modifier_jeepers_trap_debuff = class({})

function modifier_jeepers_trap_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end

function modifier_jeepers_trap_debuff:GetModifierMoveSpeedBonus_Constant()	
	return -150
end

function modifier_jeepers_trap_debuff:GetTexture()
    return "life_stealer_open_wounds"
end

function modifier_jeepers_trap_debuff:IsHidden()
    return false
end

function modifier_jeepers_trap_debuff:RemoveOnDeath()
    return true
end

function modifier_jeepers_trap_debuff:GetEffectName()
    --return "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf"
end

function modifier_jeepers_trap_debuff:OnCreated()
	if IsServer() then	
		if self:GetCaster() and self:GetParent() then
			ApplyDamage(
				{
					victim = self:GetParent(),
					attacker = self:GetCaster(),
					damage = 200,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					ability = self,
				}
			)
		end
	end
end