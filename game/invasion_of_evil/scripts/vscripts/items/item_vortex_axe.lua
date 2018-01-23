
function OnEquip()
	--print("OnEquip")

end

function OnUnequip(data)
	--print("OnUnequip")
	data.caster:RemoveModifierByName("modifier_vortex_axe")
	data.caster:RemoveModifierByName("modifier_vortex_axe_second")
	data.caster:RemoveModifierByName("modifier_vortex_axe_third")	
end


function OnToggle(data)
	--print("OnToggle")
	local caster = data.caster
	local itemName = data.ability:GetAbilityName()
	local modifName = "modifier_vortex_axe"
	local modifTable = caster:FindAllModifiers()
	local deactivate = false

	for i = 1, #modifTable do
		if modifTable[i]:GetName():find("modifier_vortex_axe")  then
			deactivate = true
		end
	end

	if itemName == "item_vortex_axe" then
		modifName = "modifier_vortex_axe"
	end	

	if itemName == "item_vortex_axe_second" then
		modifName = "modifier_vortex_axe_second"
	end	

	if itemName == "item_vortex_axe_third" then
		modifName = "modifier_vortex_axe_third"
	end		

	if deactivate then
		caster:RemoveModifierByName("modifier_vortex_axe")
		caster:RemoveModifierByName("modifier_vortex_axe_second")
		caster:RemoveModifierByName("modifier_vortex_axe_third")
	else
		caster:AddNewModifier(caster, self, modifName, {})
	end

end