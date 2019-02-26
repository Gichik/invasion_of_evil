
if item_enchantment_aura_bonus_armor == nil then
    item_enchantment_aura_bonus_armor = class({})
end

item = item_enchantment_aura_bonus_armor


function GetSkillName()
    return "enchantment_aura_bonus_armor"
end

function GetAbility(hTarget)
    return hTarget:FindAbilityByName(GetSkillName())
end

function item:GetChannelAnimation()
    return ACT_DOTA_ATTACK2
end

function item:GetCastAnimation()
    return ACT_DOTA_ATTACK2
end


function item:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:GetUnitName() ~= "npc_guardian" then
			return UF_FAIL_CUSTOM
		end

		if hTarget:HasAbility(GetSkillName()) then
			if GetAbility(hTarget):GetLevel() >= GetAbility(hTarget):GetMaxLevel() then
				return UF_FAIL_CUSTOM
			else
				return UF_SUCCESS
			end
		end	

		if hTarget.busyAbilitySlots then
			if hTarget.busyAbilitySlots == 3 then
				return UF_FAIL_CUSTOM
			end
		end

		return UF_SUCCESS
	end
end


function item:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:GetUnitName() ~= "npc_guardian" then
			return "#dota_hud_system_error_bad_target"
		end

		if hTarget:HasAbility(GetSkillName()) then
			if GetAbility(hTarget):GetLevel() >= GetAbility(hTarget):GetMaxLevel() then
				return "#dota_hud_error_max_upgrade_enchantment"
			else
				return UF_SUCCESS
			end
		end	

		if hTarget.busyAbilitySlots then
			if hTarget.busyAbilitySlots == 3 then
				return "#dota_hud_error_full_enchantment_slots"
			end
		end

		return UF_SUCCESS
	end
end

function item:OnSpellStart()		
	--print("OnSpellStart")
	local hTarget = self:GetCursorTarget()
	local ability = nil

	hTarget:EmitSound("DOTA_Item.MedallionOfCourage.Activate")
	if hTarget:HasAbility(GetSkillName()) then
		ability = hTarget:FindAbilityByName(GetSkillName())
	else

		if not hTarget.busyAbilitySlots then
			hTarget.busyAbilitySlots = 0
		end

		hTarget.busyAbilitySlots = hTarget.busyAbilitySlots + 1

		hTarget:RemoveAbility("tower_empty_slot_" .. hTarget.busyAbilitySlots)
		ability = hTarget:AddAbility(GetSkillName())
	end

	ability:UpgradeAbility(false)

	RemoveEnchantFromHero(self)
end

function RemoveEnchantFromHero(ability)
	local caster = ability:GetCaster()
	local item = nil
	local charges = 0
	local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == ability:GetName() then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
						return nil
					else
						caster:RemoveItem(item)
						return nil
					end
				else
					caster:RemoveItem(item)	
					return nil		
				end
			end
		end
	end	
end
