
function OnEquip()
	--print("OnEquip")

end

function OnUnequip(data)
	--print("OnUnequip")
	data.caster:RemoveModifierByName("modifier_chain_lightning")
	data.caster:RemoveModifierByName("modifier_chain_lightning_second")
	data.caster:RemoveModifierByName("modifier_chain_lightning_third")
end


function OnToggle(data)
	--print("OnToggle")
	local caster = data.caster
	local itemName = data.ability:GetAbilityName()
	local modifName = "modifier_chain_lightning"
	local modifTable = caster:FindAllModifiers()
	local deactivate = false

	for i = 1, #modifTable do
		if modifTable[i]:GetName():find("modifier_chain_lightning")  then
			deactivate = true
		end
	end

	if itemName == "item_chain_lightning_scepter" then
		modifName = "modifier_chain_lightning"
	end	

	if itemName == "item_chain_lightning_scepter_second" then
		modifName = "modifier_chain_lightning_second"
	end	

	if itemName == "item_chain_lightning_scepter_third" then
		modifName = "modifier_chain_lightning_third"
	end		

	if deactivate then
		caster:RemoveModifierByName("modifier_chain_lightning")
		caster:RemoveModifierByName("modifier_chain_lightning_second")
		caster:RemoveModifierByName("modifier_chain_lightning_third")
	else
		caster:AddNewModifier(caster, self, modifName, {})
	end

end