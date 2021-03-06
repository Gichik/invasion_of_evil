
if item_tran_grass == nil then
	item_tran_grass = class({})
end

--фильтры нужны, когда отключен автоподбор
function item_tran_grass:CastFilterResult()
	--print("Error")
	if IsServer() then
		if self:GetCaster() then
			local modifier = self:GetCaster():FindModifierByName("modifier_tran_grass")
			if modifier then
				if modifier:GetStackCount() >= self:GetSpecialValueFor("count_for_dung")  then
					return UF_FAIL_CUSTOM
				end
			end	

			if self:GetCurrentCharges() < self:GetInitialCharges() then
				return UF_FAIL_CUSTOM
			end

			return UF_SUCCESS
		end
		return UF_FAIL_CUSTOM		
	end
end


function item_tran_grass:GetCustomCastError()
	--print("Error")
	if IsServer() then
		if self:GetCaster() then
			local modifier = self:GetCaster():FindModifierByName("modifier_tran_grass")
			if modifier then
				if modifier:GetStackCount() >= self:GetSpecialValueFor("count_for_dung") then
					return "#dota_hud_full_tran_grass"
				end
			end
				
			if self:GetCurrentCharges() < self:GetInitialCharges() then
				return "#dota_hud_error_havent_charges"
			end

			return UF_SUCCESS
		end	
		return "#dota_hud_error_havent_charges"
	end
end

function item_tran_grass:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")
		local hCaster = self:GetCaster()
		local hItem = self
		local modifier = self:GetCaster():FindModifierByName("modifier_tran_grass") or nil

		--проверка при автоподборе
		if modifier then
			if modifier:GetStackCount() >= self:GetSpecialValueFor("count_for_dung") then
				main:CreateDrop("item_tran_grass", hCaster:GetAbsOrigin())
				hCaster:RemoveItem(hItem)
				return nil
			end
		end

		if modifier then
			modifier:IncrementStackCount()
		else
			hCaster:AddNewModifier(hCaster, self, "modifier_tran_grass", {}):IncrementStackCount()
		end

		if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
			hCaster:RemoveItem(hItem)
		else
			hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
		end
	end
end

