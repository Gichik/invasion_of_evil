
function OnEquip()
	--print("OnEquip")

end

function OnUnequip(data)
	--print("OnUnequip")
	data.caster:RemoveModifierByName("modifier_strychnine_dagger")
	data.caster:RemoveModifierByName("modifier_strychnine_dagger_second")
	data.caster:RemoveModifierByName("modifier_strychnine_dagger_third")	
end


function OnToggle(data)
	--print("OnToggle")
	local caster = data.caster
	local itemName = data.ability:GetAbilityName()
	local modifName = "modifier_strychnine_dagger"
	local modifTable = caster:FindAllModifiers()
	local deactivate = false

	for i = 1, #modifTable do
		if modifTable[i]:GetName():find("modifier_strychnine_dagger")  then
			deactivate = true
		end
	end

	if itemName == "item_strychnine_dagger" then
		modifName = "modifier_strychnine_dagger"
	end	

	if itemName == "item_strychnine_dagger_second" then
		modifName = "modifier_strychnine_dagger_second"
	end	

	if itemName == "item_strychnine_dagger_third" then
		modifName = "modifier_strychnine_dagger_third"
	end		

	if deactivate then
		caster:RemoveModifierByName("modifier_strychnine_dagger")
		caster:RemoveModifierByName("modifier_strychnine_dagger_second")
		caster:RemoveModifierByName("modifier_strychnine_dagger_third")
	else
		caster:AddNewModifier(caster, data.ability, modifName, {})
	end

end