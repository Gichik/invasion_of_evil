

function ApplyModifierToUnit(data)
	--print("ApplyModifierToUnit")
	data.caster:AddNewModifier(data.caster, data.ability, data.ModifName, {})
end

function AddPathAbilitiesToHero(data)
    --print("AddPathAbilitiesToHero")

	local hHero = data.caster
	local pathName = data.Path
	local abilityTier = tonumber(data.Tier)

	if abilityTier >= 4 then
		return nil
	end

	if abilityTier == 1 then
		local hAbility = nil
	    for i = 0, 3 do
	        hAbility = hHero:GetAbilityByIndex(i)
	        if hAbility then
	            hHero:RemoveAbility(hAbility:GetAbilityName())
	        end
	    end		
	end

    if pathName == "sapient" then
        if abilityTier == 1 then
            hHero:AddAbility("sapient_flows_of_life")
            hHero:AddAbility("sapient_flows_of_magic")
            hHero:AddAbility("sapient_cheerful_spirit")
            hHero:AddAbility("sapient_strength_of_mind")
        end
        if abilityTier == 2 then
            hHero:AddAbility("sapient_mana_shield")
            hHero:AddAbility("sapient_concentration")
            hHero:AddAbility("sapient_knowledge_of_ancients")
        end
        if abilityTier == 3 then
            hHero:AddAbility("sapient_sapience")
            hHero:AddAbility("sapient_magic_circle")
        end
    end

    if pathName == "berserk" then
        if abilityTier == 1 then
	        hHero:AddAbility("berserk_ripper")
	        hHero:AddAbility("berserk_heavy")
	        hHero:AddAbility("berserk_knowledge_elders")
	        hHero:AddAbility("berserk_durability")
        end
        if abilityTier == 2 then
            hHero:AddAbility("berserk_heroism")
            hHero:AddAbility("berserk_battle_rage")
            hHero:AddAbility("berserk_rage")
        end
        if abilityTier == 3 then
            hHero:AddAbility("berserk_riot")
            hHero:AddAbility("berserk_runner")
        end
    end

    if pathName == "templar" then
        if abilityTier == 1 then
	        hHero:AddAbility("templar_strength_of_will")
	        hHero:AddAbility("templar_experience")
	        hHero:AddAbility("templar_shield_bearer")
	        hHero:AddAbility("templar_frightfulness")
        end
        if abilityTier == 2 then
            hHero:AddAbility("templar_heavy_armor")
            hHero:AddAbility("templar_strength_of_body")
            hHero:AddAbility("templar_fruits_of_training")
        end
        if abilityTier == 3 then
            hHero:AddAbility("templar_nobleness")
            hHero:AddAbility("templar_taunt")
        end
    end    

end