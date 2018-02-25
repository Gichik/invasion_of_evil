
if modifier_vortex_axe == nil then
    modifier_vortex_axe = class({})
end

--rotate = 0

function modifier_vortex_axe:IsHidden()
	return false
end

function modifier_vortex_axe:IsPurgable()
	return false
end

function modifier_vortex_axe:GetTexture()
    return "custom_folder/vortex"
end

function modifier_vortex_axe:RemoveOnDeath()
	return true
end

function modifier_vortex_axe:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_EVENT_ON_ORDER
    }
    return funcs
end


function modifier_vortex_axe:GetOverrideAnimation()	
	return ACT_DOTA_CAPTURE
end

function modifier_vortex_axe:GetAbilityDamageType()	
	return DAMAGE_TYPE_PHYSICAL
end

function modifier_vortex_axe:GetAbilityDamage()	
	return self.damage
end

function modifier_vortex_axe:GetModifierConstantManaRegen()	
	return -self.manaCost
end

function modifier_vortex_axe:OnOrder(data)
	local caster = self:GetParent()
    caster.new_forward = (data.new_pos - caster:GetOrigin()):Normalized()
	caster.new_pos = data.new_pos
end


function modifier_vortex_axe:OnCreated(data)
	self.manaCost = 10
	
	if IsServer() then
		self.parent = self:GetParent()

		if self.blade_fury_spin_pfx then
			ParticleManager:DestroyParticle(self.blade_fury_spin_pfx, false)
			ParticleManager:ReleaseParticleIndex(self.blade_fury_spin_pfx)
		end

		self.blade_fury_spin_pfx = nil
		self.speed = self.parent:GetBaseMoveSpeed()/50
		self.rotate = 1
		self.rotateMax = 12
		self.think = 0.03
		self.dmgMultiply = self:GetAbility():GetSpecialValueFor("str_in_dmg_perc")/100 or 0
		self.curr_pos = self.parent:GetAbsOrigin()
		self.new_pos = nil
		self.new_forward = nil
		
		self:StartIntervalThink(self.think)
	end
end


function modifier_vortex_axe:OnIntervalThink()
	if self:GetParent() then
		if self.parent:GetMana() > 0 and self.parent:IsAlive() then
			self.rotate = self.rotate + 1
			if self.rotate == self.rotateMax then
				self.rotate = 1
				self:ApplyDamage()
				--self.parent:SpendMana(50, self)
			end
			self:PlayAnimation()
		else
			self:Destroy()
		end
	end
end


function modifier_vortex_axe:OnDestroy()
	if IsServer() then
		if self.blade_fury_spin_pfx then
			ParticleManager:DestroyParticle(self.blade_fury_spin_pfx, false)
			ParticleManager:ReleaseParticleIndex(self.blade_fury_spin_pfx)
			self.blade_fury_spin_pfx = nil
		end
		if self:GetParent() then
			FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false) 
			self.parent:StopSound("Hero_Juggernaut.BladeFuryStart")
			self.parent:EmitSound("Hero_Juggernaut.BladeFuryStop")
		end
	end
end


function modifier_vortex_axe:PlayAnimation()
	if self:GetParent() then
		if self:GetParent():IsAlive() then
			if not self.blade_fury_spin_pfx then
				self.blade_fury_spin_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
				ParticleManager:SetParticleControl(self.blade_fury_spin_pfx, 5, Vector(250 * 1.2, 0, 0))
				self.parent:EmitSound("Hero_Juggernaut.BladeFuryStart")
			end

			self.parent:SetAngles(0,30*self.rotate,0)
			self.parent:StartGesture(ACT_DOTA_ATTACK)

			self.curr_pos = self.parent:GetAbsOrigin()
			self.new_pos = self.parent.new_pos
			self.new_forward = self.parent.new_forward

			self.speed = self.parent:GetBaseMoveSpeed()/50

			if self.new_pos == Vector(0,0,0) then
				self.new_pos = self.curr_pos
			end
			
			if self.curr_pos and self.new_pos and self.speed and self.new_forward then
				if self:ShouldMove(self.curr_pos,self.new_pos) then
					local vNewStep = self.curr_pos + self.speed*self.new_forward
			        if GridNav:CanFindPath( self.curr_pos, vNewStep ) then
						self:GetParent():SetOrigin( vNewStep )
					end
				end
			end	
		end
	end
end

function modifier_vortex_axe:ShouldMove(VectorA, VectorB)
	if VectorA == VectorB then
		return false
	end

	local distance = math.sqrt((VectorA.x-VectorB.x)*(VectorA.x-VectorB.x) + (VectorA.y-VectorB.y)*(VectorA.y-VectorB.y))

	if distance <= 10 then
		return false
	end

	return true
end

function modifier_vortex_axe:ApplyDamage()
	if self:GetParent() then

		local dmg = self.dmgMultiply*(self.parent:GetStrength()*self.rotateMax*self.think) or 0

		local units = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.parent, 250,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units then
			for i = 1, #units do		
		        ApplyDamage({
		            victim = units[ i ],
		            attacker = self.parent,
		            damage = dmg,
		            damage_type = self:GetAbilityDamageType(),
		            ability = self
		           })		
			end
		end
	end
end

