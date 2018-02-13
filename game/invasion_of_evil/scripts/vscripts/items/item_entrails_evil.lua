require( 'constant_links' )
if item_entrails_evil == nil then
	item_entrails_evil = class({})
end


function item_entrails_evil:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return UF_FAIL_CUSTOM
		end		

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end		

		if PORTAL_OW_EXIST == true then
			return UF_FAIL_CUSTOM
		end	

		return UF_SUCCESS
	end
end


function item_entrails_evil:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_necromant_base"  then
			return "#dota_hud_error_bad_target"
		end	

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end	

		if PORTAL_OW_EXIST == true then
			return "#dota_hud_error_necromant_tired"
		end	

		return UF_SUCCESS
	end
end

function item_entrails_evil:OnSpellStart()
	if IsServer() then

	--print("OnSpellStart")

		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorTarget()
		local hItem = self
		local itemName = self:GetAbilityName()
		local newItem = nil

		hTarget:EmitSound("Item.DropWorld")
		if hTarget:GetUnitName() == "npc_necromant_base" then

			if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
				hCaster:RemoveItem(hItem)
			else
				hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
			end

			if hTarget:HasModifier("modifier_teleport_progress") then
				local modifier = hTarget:FindModifierByName("modifier_teleport_progress")
				modifier:IncrementStackCount()
				if modifier:GetStackCount() >= ENTRAILS_FOR_PORTAL then
					hTarget:RemoveModifierByName("modifier_teleport_progress")
					self:CreateNewPortal()
				end
			else
				hTarget:AddNewModifier(hTarget, nil, "modifier_teleport_progress", {}):IncrementStackCount()
			end
			
		end
	end
end


function item_entrails_evil:CreatePortalAnimation()
	if IsServer() then
		--print("CreatePortalAnimation")
		if self.tpParticleID == nil and PORTAL_OW_POINT then
	    	self.tpParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf", PATTACH_CUSTOMORIGIN, self)
	    	ParticleManager:SetParticleControl(self.tpParticleID, 0, PORTAL_OW_POINT )
	   		ParticleManager:SetParticleControl(self.tpParticleID, 1, Vector(300, 0, 0))
		end
	end
end

function item_entrails_evil:DestroyPortal()
	if IsServer() then
		--print("DestroyPortal")
		main:SetPortalOwExist(false)
		if self.tpParticleID then
			ParticleManager:DestroyParticle(self.tpParticleID, false)
			ParticleManager:ReleaseParticleIndex(self.tpParticleID)
			self.tpParticleID = nil
		end

		local units = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, SPAWNER_OW_POINT, nil, 2000,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units then	
			for i = 1, #units do
				if units[i]:IsRealHero() then
					units[i]:RespawnHero(false, false)
					main:FocusCameraOnPlayer(units[i])
				else
					UTIL_Remove(units[i])
				end
			end
		end

		units = FindUnitsInRadius( DOTA_TEAM_NEUTRALS, SPAWNER_OW_POINT, nil, 2000,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
		if units then	
			for i = 1, #units do
				UTIL_Remove(units[i])
			end
		end
	end	
end

function item_entrails_evil:CreateNewPortal()
	--print("CreateNewPortal")
	main:SetPortalOwExist(true)
	self:CreatePortalAnimation()
	StartSoundEventFromPosition("Hero_ShadowDemon.Disruption",PORTAL_OW_POINT)
	self:SpawnNewOWBoss()
    Timers:CreateTimer(PORTAL_OW_DURATION, function()
        self:DestroyPortal()
      	return nil
    end
    )


    
end

function item_entrails_evil:SpawnNewOWBoss()
    local unit = nil
    
    unit = CreateUnitByName(GetUnitNameFor("church",1), SPAWNER_OW_POINT, true, nil, nil, DOTA_TEAM_NEUTRALS ) 

    local modifier = unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})

    for i = 1, BOSS_MINIONS_COUNT do 
        unit = CreateUnitByName(GetUnitNameFor("church",2), SPAWNER_OW_POINT + RandomVector(100), true, nil, nil, DOTA_TEAM_NEUTRALS )
        if modifier:CanBeAddToMinions() then
            unit:AddNewModifier(unit, nil, modifier:GetName(), {})
        end
    end
end