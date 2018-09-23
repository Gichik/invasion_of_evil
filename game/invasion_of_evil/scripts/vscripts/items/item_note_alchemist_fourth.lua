
if item_note_alchemist_fourth == nil then
	item_note_alchemist_fourth = class({})
end


function item_note_alchemist_fourth:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_alchemist_book"  then
			return UF_FAIL_CUSTOM
		end			

		return UF_SUCCESS
	end
end


function item_note_alchemist_fourth:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_alchemist_book"  then
			return "#dota_hud_system_error_bad_target"
		end	

		return UF_SUCCESS
	end
end

function item_note_alchemist_fourth:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self

		hTarget:EmitSound("Item.TomeOfKnowledge")
		if hTarget:GetUnitName() == "npc_alchemist_book" then
			hCaster:RemoveItem(hItem)
			main:CreateDrop("item_note_alchemist_fifth", hCaster:GetAbsOrigin())

			local point = Entities:FindByName( nil, "npc_spawner_alchemist_3" ):GetAbsOrigin()
			local unit = CreateUnitByName("npc_alchemist_ghost", point, true, nil, nil, DOTA_TEAM_GOODGUYS )
			unit:AddNewModifier(unit, nil, "modifier_no_health_bar", {})
			unit:AddNewModifier(unit, nil, "modifier_npc_invulnerable", {})
			unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 15})
			unit:SetForwardVector(Vector(1,-1,0))

		end
	end
end