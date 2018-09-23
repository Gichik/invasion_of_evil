
if item_note_alchemist_two == nil then
	item_note_alchemist_two = class({})
end


function item_note_alchemist_two:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_alchemist_tombstone"  then
			return UF_FAIL_CUSTOM
		end			

		return UF_SUCCESS
	end
end


function item_note_alchemist_two:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_alchemist_tombstone"  then
			return "#dota_hud_system_error_bad_target"
		end	

		return UF_SUCCESS
	end
end

function item_note_alchemist_two:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self

		hTarget:EmitSound("Item.TomeOfKnowledge")
		if hTarget:GetUnitName() == "npc_alchemist_tombstone" then
			hCaster:RemoveItem(hItem)
			main:CreateDrop("item_note_alchemist_three", hCaster:GetAbsOrigin())
		end
	end
end