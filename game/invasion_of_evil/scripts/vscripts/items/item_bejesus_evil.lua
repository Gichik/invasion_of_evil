
if item_bejesus_evil == nil then
	item_bejesus_evil = class({})
end


function item_bejesus_evil:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return UF_FAIL_CUSTOM
		end		

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end		

		return UF_SUCCESS
	end
end


function item_bejesus_evil:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return "#dota_hud_error_bad_target"
		end	

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end		

		return UF_SUCCESS
	end
end

function item_bejesus_evil:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil

	hTarget:EmitSound("Item.DropWorld")
	if hTarget:GetUnitName() == "npc_necromant_base" then

		if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
			hCaster:RemoveItem(hItem)
		else
			hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
		end

		if hTarget:HasModifier("modifier_teleport_progress") then
			local modifier = hTarget:FindModifierByName("modifier_teleport_progress")
			modifier:IncrementStackCount()
			if modifier:GetStackCount() >= 3 then
				print("ok")
				hTarget:RemoveModifierByName("modifier_teleport_progress")
			end
		else
			hTarget:AddNewModifier(hTarget, nil, "modifier_teleport_progress", {}):IncrementStackCount()
		end
		
	end
end


