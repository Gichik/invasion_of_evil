
if modifier_exile_trophies == nil then
    modifier_exile_trophies = class({})
end

function modifier_exile_trophies:IsHidden()
	return false
end

function modifier_exile_trophies:RemoveOnDeath()
	return false
end

function modifier_exile_trophies:GetTexture()
    return "warlock_fatal_bonds"
end

function modifier_exile_trophies:OnCreated()
 	if IsServer() then
 		self.auraRadius = self:GetAbility():GetCastRange()
    	self.think = 0.5
		self:StartIntervalThink(self.think)
	end   
end

function modifier_exile_trophies:OnIntervalThink()
	if self:GetParent() then

		local parent = self:GetParent()
		local hItem = nil
		local modifier = nil

		if parent:HasItemInInventory("item_skull_of_evil") then
			for i = 0, 8 do
				hItem = parent:GetItemInSlot(i)
				if hItem ~= nil then
					if hItem:GetAbilityName() == "item_skull_of_evil" then
						if hItem:GetCurrentCharges() < self:GetAbility():GetSpecialValueFor("max_stacks") then
							self:SetStackCount(hItem:GetCurrentCharges())
						else
							self:SetStackCount(self:GetAbility():GetSpecialValueFor("max_stacks"))
						end
					end
				end 
			end
		end

		local units = FindUnitsInRadius( 	parent:GetTeamNumber(), 
											parent:GetAbsOrigin(), 
											parent, self.auraRadius,
											DOTA_UNIT_TARGET_TEAM_ENEMY,
											DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 
											DOTA_UNIT_TARGET_FLAG_NONE, 
											0, 
											false )
			
		if units then	
			for i = 1, #units do	
				modifier = units[i]:AddNewModifier(parent, self:GetAbility(), "modifier_exile_trophies_debuff", {duration =  1})
				modifier:SetStackCount(self:GetStackCount())
			end
		end	

	end
end


---------------------------------------------------
modifier_exile_trophies_debuff = class({})


function modifier_exile_trophies_debuff:IsHidden()
	return false
end

function modifier_exile_trophies_debuff:GetTexture()
    return "warlock_fatal_bonds"
end

function modifier_exile_trophies_debuff:RemoveOnDeath()
	return true
end

function modifier_exile_trophies_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end

function modifier_exile_trophies_debuff:GetModifierPhysicalArmorBonus()	
	return -self:GetStackCount()*self:GetAbility():GetSpecialValueFor("reduce_armor") or 0
end