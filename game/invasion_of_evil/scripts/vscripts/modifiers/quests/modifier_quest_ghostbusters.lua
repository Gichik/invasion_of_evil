
if modifier_quest_ghostbusters == nil then
    modifier_quest_ghostbusters = class({})
end

function modifier_quest_ghostbusters:IsHidden()
	return false
end

function modifier_quest_ghostbusters:GetTexture()
    return "item_tpscroll"
end

function modifier_quest_ghostbusters:RemoveOnDeath()
	return false
end

function modifier_quest_ghostbusters:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH
    }
    return funcs
end


--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_quest_ghostbusters:OnDeath(data)
	if IsServer() and self:GetParent() then
		self.parent = self:GetParent()


		if data.unit:GetUnitName():find("npc_start_boss_") then

			local applyQuest = false

			if data.attacker:IsRealHero() then
				if data.attacker == self.parent then
					applyQuest = true
				end
			else
				if data.attacker:GetOwner() then
					if data.attacker:GetOwner() == self.parent then
						applyQuest = true
					end
				end
			end 

			if applyQuest then
				local accept = false
				local bossNumber = data.unit:GetUnitName():sub(16)

				if not data.attacker.ghostbusters then
					accept = true
					data.attacker.ghostbusters = bossNumber
				elseif not data.attacker.ghostbusters:find(bossNumber) then
						accept = true
						data.attacker.ghostbusters = data.attacker.ghostbusters .. bossNumber
				end 

				if self:GetStackCount() <= 2 and accept then
					EmitSoundOn("Hero_Undying.SoulRip.Cast", data.unit)
					local particleID = ParticleManager:CreateParticle( "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", PATTACH_ABSORIGIN, self.parent)
					ParticleManager:SetParticleControl(particleID, 0, data.unit:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(particleID, 1, self.parent, PATTACH_ABSORIGIN, "", self.parent:GetAbsOrigin(), true )
					ParticleManager:ReleaseParticleIndex(particleID)
					self:IncrementStackCount()
				end

				if self:GetStackCount() >= 3 then
					EmitSoundOn("Tutorial.Quest.complete_01", self.parent)
					self.parent:AddNewModifier(self.parent, nil, "modifier_achievement_ghostbusters", {})
					self:Destroy()
				end

			end
		end
	end
end