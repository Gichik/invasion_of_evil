
if modifier_tran_grass == nil then
	modifier_tran_grass = class({})
end

function modifier_tran_grass:IsHidden()
	return false
end

function modifier_tran_grass:RemoveOnDeath()
	return true
end

function modifier_tran_grass:DeclareFunctions()
	return nil
end


function modifier_tran_grass:GetTexture()
    return "item_tango"
end


function modifier_tran_grass:OnCreated( data )
	if IsServer() then
		self.caster = self:GetCaster()
		self.tree_pos = Entities:FindByName( nil, "cursed_tree"):GetAbsOrigin()
		self.tp_point = Entities:FindByName( nil, "dungeon_cursed_hero_spawner"):GetAbsOrigin()
		self.countForDung = self:GetAbility():GetSpecialValueFor("count_for_dung")
		self:StartIntervalThink(1)
	end
end

function modifier_tran_grass:OnIntervalThink()
	if self:GetCaster() then
		if self:GetStackCount() >= self.countForDung then
			if self:CanBeMoved(self.caster:GetAbsOrigin(), self.tree_pos) then
				self.caster:SetAbsOrigin(self.tp_point) 
				FindClearSpaceForUnit(self.caster, self.caster:GetAbsOrigin(), false) 
				self.caster:Stop()
				main:FocusCameraOnPlayer(self.caster)
				self:Destroy()
			end
		end
	end
end


function modifier_tran_grass:CanBeMoved(VectorA, VectorB)
	if VectorA == VectorB then
		return true
	end

	local distance = math.sqrt((VectorA.x-VectorB.x)*(VectorA.x-VectorB.x) + (VectorA.y-VectorB.y)*(VectorA.y-VectorB.y))

	if distance <= 300 then
		return true
	end

	return false
end