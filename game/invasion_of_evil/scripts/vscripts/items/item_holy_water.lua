
if item_holy_water == nil then
	item_holy_water = class({})
end


function item_holy_water:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_mini_boss"  then
			return UF_FAIL_CUSTOM
		end		

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end		

		return UF_SUCCESS
	end
end


function item_holy_water:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_mini_boss"  then
			return "#dota_hud_error_bad_target"
		end	

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end	

		return UF_SUCCESS
	end
end

function item_holy_water:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self

		hTarget:EmitSound("RiverPaint.Cast")
		if hTarget:GetUnitName() == "npc_mini_boss" then

			if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
				hCaster:RemoveItem(hItem)
			else
				hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
			end

			hTarget:ForceKill(false)
			
		end
	end
end