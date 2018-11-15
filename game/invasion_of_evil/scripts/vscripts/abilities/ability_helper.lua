

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
            hHero:AddAbility("berserk_spirit_of_war")
            hHero:AddAbility("berserk_spirit_of_nimbleness")
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
            hHero:AddAbility("templar_blessing")
        end
    end   

    if pathName == "dishonored" then
        if abilityTier == 1 then
            hHero:AddAbility("dishonored_counterattack")
            hHero:AddAbility("dishonored_insidious")
            hHero:AddAbility("dishonored_honed_blows")
            hHero:AddAbility("dishonored_strength_of_body")
        end
        if abilityTier == 2 then
            hHero:AddAbility("dishonored_sword_dance")
            hHero:AddAbility("dishonored_second_breath")
            hHero:AddAbility("dishonored_leather_armor")
        end
        if abilityTier == 3 then
            hHero:AddAbility("dishonored_acuteness_reaction")
            hHero:AddAbility("dishonored_fleetness")
        end
    end  

    if pathName == "summoner" then
        if abilityTier == 1 then
            hHero:AddAbility("summoner_natural_density")
            hHero:AddAbility("summoner_internal_power")
            hHero:AddAbility("summoner_vampirism")
            hHero:AddAbility("summoner_sapience")
        end
        if abilityTier == 2 then
            hHero:AddAbility("summoner_mammock")
            hHero:AddAbility("summoner_predator")
            hHero:AddAbility("summoner_aesculapius")
        end
        if abilityTier == 3 then
            --hHero:AddAbility("summoner_third_eye_dummy")
            hHero:AddAbility("summoner_deep_knowledge")
            hHero:AddAbility("summoner_synergy")
        end
    end

    if pathName == "exile" then
        if abilityTier == 1 then
            hHero:AddAbility("exile_alert")
            hHero:AddAbility("exile_ardor")
            hHero:AddAbility("exile_trophies")
            hHero:AddAbility("exile_meditation")
        end
        if abilityTier == 2 then
            hHero:AddAbility("exile_riot")
            hHero:AddAbility("exile_severity")
            hHero:AddAbility("exile_intimidation")
        end
        if abilityTier == 3 then
            hHero:AddAbility("exile_highlander")
            hHero:AddAbility("exile_zeal")
        end
    end

    if pathName == "vampire" then
        if abilityTier == 1 then
            hHero:AddAbility("vampire_blood_magic")
            hHero:AddAbility("vampire_aura_of_death")
            hHero:AddAbility("vampire_beast_of_the_night")
            hHero:AddAbility("vampire_night_power")
        end
        if abilityTier == 2 then
            hHero:AddAbility("vampire_sower_of_weakness")
            hHero:AddAbility("vampire_sower_of_horror")
            hHero:AddAbility("vampire_sower_of_pain")
        end
        if abilityTier == 3 then
            hHero:AddAbility("vampire_sucking_life")
            hHero:AddAbility("vampire_power_of_demon")
        end
    end  

end
