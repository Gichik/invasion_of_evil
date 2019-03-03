


--[[
ability
caster_entindex
unit
ScriptFile
caster
Function
attacker
]]

function ApplyResetPoison(data)

	--print("OnSpellStart")
	local hCaster = data.caster
    local playerID = hCaster:GetPlayerID()
	hCaster:EmitSound("Item.LotusOrb.Target")

    if playerID ~= nil and playerID ~= -1 then
	    local newHero = nil
	    local ability = nil
	    local item = nil
	    local oHealth = nil
	    local oMana = nil
	    local abilityCount = hCaster:GetAbilityCount()
	    local stat = data.Stat
	    local currXP = hCaster:GetCurrentXP()

	    if hCaster:GetLevel() >= 25 then
	    	currXP = 0
		    if stat == "strength" then
			    if not hCaster.numResetBonusStr then
					hCaster.numResetBonusStr = 0
				end
				hCaster.numResetBonusStr = hCaster.numResetBonusStr + 1	    	
		    end

		    if stat == "agility" then
			    if not hCaster.numResetBonusAgi then
					hCaster.numResetBonusAgi = 0
				end
				hCaster.numResetBonusAgi = hCaster.numResetBonusAgi + 1	    	
		    end

		    if stat == "intelligence" then
			    if not hCaster.numResetBonusInt then
					hCaster.numResetBonusInt = 0
				end
				hCaster.numResetBonusInt = hCaster.numResetBonusInt + 1
		    end	 
		end   

		--удаляем само зелье
		for i = 0, 8 do
			item = hCaster:GetItemInSlot(i)
			if item ~= nil then
				if item:GetAbilityName() == data.ability:GetAbilityName() then
					hCaster:RemoveItem(item)
					break
				end
			end
		end

    	--дропаем вещи с зарядами (сердце, воду, черепа)
		for i = 0, 11 do
			item = hCaster:GetItemInSlot(i)
			if item ~= nil then
				if item:GetCurrentCharges() > 1 and item:IsDroppable() then
					hCaster:DropItemAtPositionImmediate(item, hCaster:GetAbsOrigin())
				end
			end
		end

        for i = 0, abilityCount-1 do
            ability = hCaster:GetAbilityByIndex(i)
            if ability then
                hCaster:RemoveAbility(ability:GetAbilityName())
            end
        end

        oHealth = hCaster:GetHealth()
        oMana = hCaster:GetMana()


        newHero = PlayerResource:ReplaceHeroWith(playerID, hCaster:GetName(), hCaster:GetGold(), currXP)
       
        if hCaster:HasModifier("modifier_quest_dungeon_church") then
            newHero:AddNewModifier(newHero, nil, "modifier_quest_dungeon_church", {})
        end

        if hCaster:HasModifier("modifier_quest_dungeon_cursed") then
            newHero:AddNewModifier(newHero, nil, "modifier_quest_dungeon_cursed", {})
        end


        if hCaster:HasModifier("modifier_quest_dungeon_cemetry") then
            newHero:AddNewModifier(newHero, nil, "modifier_quest_dungeon_cemetry", {})
        end

        if hCaster:HasModifier("modifier_alchemy") then
            newHero:AddNewModifier(newHero, nil, "modifier_alchemy", {})
        end

        if hCaster:HasModifier("modifier_achievement_ghostbusters") then
            newHero:AddNewModifier(newHero, nil, "modifier_achievement_ghostbusters", {})
        end

        if hCaster.numResetBonusStr then
            newHero.numResetBonusStr = hCaster.numResetBonusStr        	
            newHero:AddNewModifier(newHero, nil, "modifier_reset_bonus_str", {}) 
        end

        if hCaster.numResetBonusAgi then
            newHero.numResetBonusAgi = hCaster.numResetBonusAgi        	
            newHero:AddNewModifier(newHero, nil, "modifier_reset_bonus_agi", {}) 
        end

        if hCaster.numResetBonusInt then
            newHero.numResetBonusInt = hCaster.numResetBonusInt        	
            newHero:AddNewModifier(newHero, nil, "modifier_reset_bonus_int", {}) 
        end	        
		   

        if newHero:GetHealth() > oHealth then
        	newHero:SetHealth(oHealth)
        end

        if newHero:GetMana() > oMana then
        	newHero:SetMana(oMana)
        end


        newHero.cursed_step = hCaster.cursed_step
        newHero.church_step = hCaster.church_step
        newHero.cemetry_step = hCaster.cemetry_step
        newHero.alchemy_step = hCaster.alchemy_step      

        UTIL_Remove(hCaster)
        --newHero:RespawnHero(false, false)

    end


end