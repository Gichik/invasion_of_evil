

function SetRespawn(data)
	--print("SetRespawn")
	local time = 5
	local moob = data.caster
	local name = moob:GetUnitName()
	local level = moob:GetLevel()		
	local SpawnLoc = moob.vSpawnLoc
	local team = DOTA_TEAM_NEUTRALS

	local minionsName = string.gsub(moob:GetUnitName(),"_spawner", "");
	local numMinions = data.NumbMinions


	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	if moob.firstDie then
		time = data.Time
		level = level - 1
	end

	Timers:CreateTimer(time, function()
	  	local unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, team )
		unit:CreatureLevelUp(level)
		unit.vSpawnLoc = SpawnLoc 
		unit.firstDie = false
		local modifier = unit:AddNewModifier(unit, nil, "modifier_distortion_carrier", {})


		for i = 1, numMinions do 
			minion = CreateUnitByName(minionsName, SpawnLoc, true, nil, nil, team )
			minion:CreatureLevelUp(level)
			if modifier:CanBeAddToMinions() then
				minion:AddNewModifier(unit, nil, modifier:GetName(), {})
			end
		end

	  return nil
	end
	)

end