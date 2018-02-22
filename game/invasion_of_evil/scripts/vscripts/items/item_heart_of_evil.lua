require( 'constant_links' )
if item_heart_of_evil == nil then
	item_heart_of_evil = class({})
end


function item_heart_of_evil:CastFilterResultTarget(hTarget)
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

		if PORTAL_OW_EXIST == true or WAVE_STATE == true then
			return UF_FAIL_CUSTOM
		end	

		return UF_SUCCESS
	end
end


function item_heart_of_evil:GetCustomCastErrorTarget(hTarget)
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

		if PORTAL_OW_EXIST == true or WAVE_STATE == true then
			return "#dota_hud_error_necromant_tired"
		end	

		return UF_SUCCESS
	end
end

function item_heart_of_evil:OnSpellStart()
	if IsServer() then

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

			if hTarget:HasModifier("modifier_heart_evil_progress") then
				local modifier = hTarget:FindModifierByName("modifier_heart_evil_progress")
				modifier:IncrementStackCount()
				if modifier:GetStackCount() >= HEART_FOR_END then
					hTarget:RemoveModifierByName("modifier_heart_evil_progress")
					hTarget:AddNewModifier(hTarget, self, "modifier_signal_animation", {duration = 2})
					GameRules:SendCustomMessageToTeam("#end_necromancer_message", DOTA_TEAM_GOODGUYS, 0, 0)
				    Timers:CreateTimer(2.3, function()
				    	self:CreateFinalBoss(hTarget)
						return nil
				    end
				    )					
				end
			else
				hTarget:AddNewModifier(hTarget, nil, "modifier_heart_evil_progress", {}):IncrementStackCount()
			end
			
		end
	end
end


function item_heart_of_evil:CreateFinalBoss(hTarget)
	UTIL_Remove(hTarget)
   	local point = Entities:FindByName( nil, "npc_spawner_1"):GetAbsOrigin()
    unit = CreateUnitByName("final_boss", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
    FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
    unit:AddNewModifier(unit, nil, "modifier_bosses_autocast", {})

    unit:EmitSound("Hero_Nightstalker.Darkness")

	GameRules:SetTimeOfDay( 0.75 )    
	GameRules:SendCustomMessageToTeam("#enigma_message", DOTA_TEAM_GOODGUYS, 0, 0)
   	--GameRules:GetGameModeEntity():SetBuybackEnabled( false )
   	
    Timers:CreateTimer(240, function()
    	GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		return nil
    end
    )   	
end