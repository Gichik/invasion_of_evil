
if item_note_dungeon_cursed_one == nil then
	item_note_dungeon_cursed_one = class({})
end


function item_note_dungeon_cursed_one:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_vern_base"  then
			return UF_FAIL_CUSTOM
		end			

		return UF_SUCCESS
	end
end


function item_note_dungeon_cursed_one:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_vern_base"  then
			return "#dota_hud_system_error_bad_target"
		end	

		return UF_SUCCESS
	end
end

function item_note_dungeon_cursed_one:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self

		hTarget:EmitSound("Item.TomeOfKnowledge")
		if hTarget:GetUnitName() == "npc_vern_base" then
			hCaster:RemoveItem(hItem)
			main:CreateDrop("item_note_dungeon_cursed_two", hCaster:GetAbsOrigin())
		end
	end
end