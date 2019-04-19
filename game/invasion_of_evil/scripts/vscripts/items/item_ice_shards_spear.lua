
function OnEquip()
	--print("OnEquip")

end

function OnUnequip(data)
	--print("OnUnequip")
	data.caster:RemoveModifierByName("modifier_ice_shards")
	data.caster:RemoveModifierByName("modifier_ice_shards_second")
	data.caster:RemoveModifierByName("modifier_ice_shards_third")
end


function OnToggle(data)
	--print("OnToggle")
	local caster = data.caster
	local itemName = data.ability:GetAbilityName()
	local modifName = "modifier_ice_shards"
	local modifTable = caster:FindAllModifiers()
	local deactivate = false

	for i = 1, #modifTable do
		if modifTable[i]:GetName():find("modifier_ice_shards")  then
			deactivate = true
		end
	end

	if itemName == "item_ice_shards_spear" then
		modifName = "modifier_ice_shards"
	end	

	if itemName == "item_ice_shards_spear_second" then
		modifName = "modifier_ice_shards_second"
	end	

	if itemName == "item_ice_shards_spear_third" then
		modifName = "modifier_ice_shards_third"
	end		

	if deactivate then
		caster:RemoveModifierByName("modifier_ice_shards")
		caster:RemoveModifierByName("modifier_ice_shards_second")
		caster:RemoveModifierByName("modifier_ice_shards_third")
	else
		caster:AddNewModifier(caster, data.ability, modifName, {})
	end

end

--снаряды привязаны к абилке, а абилка в кв отлавливает столкновение и вызывает функцию
--target,caster,caster_entindex,ScriptFile,Function,ability
function OnShardsHitUnit(data)
	if data.target and data.caster and data.ability then
		data.target:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Splinter")
        ApplyDamage({
            victim = data.target,
            attacker = data.caster,
            damage = data.caster:GetAverageTrueAttackDamage(data.target)*data.ability:GetSpecialValueFor("dmg_perc")/100,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = data.ability
           })
	end
end