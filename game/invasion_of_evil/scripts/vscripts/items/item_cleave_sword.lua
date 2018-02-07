
function OnEquip()
	--print("OnEquip")

end

function OnUnequip(data)
	--print("OnUnequip")
	data.caster:RemoveModifierByName("modifier_cleave_sword")
	data.caster:RemoveModifierByName("modifier_cleave_sword_second")
	data.caster:RemoveModifierByName("modifier_cleave_sword_third")	
end


function OnToggle(data)
	--print("OnToggle")
	local caster = data.caster
	local itemName = data.ability:GetAbilityName()
	local modifName = "modifier_cleave_sword"
	local modifTable = caster:FindAllModifiers()
	local deactivate = false

	for i = 1, #modifTable do
		if modifTable[i]:GetName():find("modifier_cleave_sword")  then
			deactivate = true
		end
	end

	if itemName == "item_cleave_sword" then
		modifName = "modifier_cleave_sword"
	end	

	if itemName == "item_cleave_sword_second" then
		modifName = "modifier_cleave_sword_second"
	end	

	if itemName == "item_cleave_sword_third" then
		modifName = "modifier_cleave_sword_third"
	end		

	if deactivate then
		caster:RemoveModifierByName("modifier_cleave_sword")
		caster:RemoveModifierByName("modifier_cleave_sword_second")
		caster:RemoveModifierByName("modifier_cleave_sword_third")
	else
		caster:AddNewModifier(caster, data.ability, modifName, {})
	end

end