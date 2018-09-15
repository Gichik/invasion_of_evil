
if modifier_quest_dungeon_jeepers == nil then
    modifier_quest_dungeon_jeepers = class({})
end

function modifier_quest_dungeon_jeepers:IsHidden()
	return false
end

function modifier_quest_dungeon_jeepers:GetTexture()
    return "item_shadow_amulet"
end

function modifier_quest_dungeon_jeepers:RemoveOnDeath()
	return false
end

function modifier_quest_dungeon_jeepers:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
    }
    return funcs
end


function modifier_quest_dungeon_jeepers:OnCreated()
	self.auraRadius = 500
end


--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_quest_dungeon_jeepers:OnDeath(data)
	if IsServer() and self:GetParent() then
		if data.unit:GetUnitName() == "npc_mini_boss" then

			local ParentAbsOrigin = self:GetParent():GetAbsOrigin()
			local UnitAbsOrigin = data.unit:GetAbsOrigin()

			if 	ParentAbsOrigin.x > UnitAbsOrigin.x - self.auraRadius and 
				ParentAbsOrigin.x < UnitAbsOrigin.x + self.auraRadius and
				ParentAbsOrigin.y > UnitAbsOrigin.y - self.auraRadius and
				ParentAbsOrigin.y < UnitAbsOrigin.y + self.auraRadius then

				if self:GetStackCount() < CHARGES_FOR_JEEPERS_DUNG then
					EmitSoundOn("Hero_Undying.SoulRip.Cast", data.unit)
					local parent = self:GetParent();
					local particleID = ParticleManager:CreateParticle( "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", PATTACH_ABSORIGIN, parent)
					ParticleManager:SetParticleControl(particleID, 0, data.unit:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(particleID, 1, parent, PATTACH_ABSORIGIN, "", parent:GetAbsOrigin(), true )
					ParticleManager:ReleaseParticleIndex(particleID)
					self:IncrementStackCount()
				end

			end
		end
	end
end