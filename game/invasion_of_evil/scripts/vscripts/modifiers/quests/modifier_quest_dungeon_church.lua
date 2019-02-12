

if modifier_quest_dungeon_church == nil then
    modifier_quest_dungeon_church = class({})
end

function modifier_quest_dungeon_church:IsHidden()
	return false
end

function modifier_quest_dungeon_church:GetTexture()
    return "item_shadow_amulet"
end

function modifier_quest_dungeon_church:RemoveOnDeath()
	return false
end

function modifier_quest_dungeon_church:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

function modifier_quest_dungeon_church:OnCreated(data)
	self.thresholdDmg = 700
	self.receivedDmg = 0
	self.parent = self:GetParent()
end


--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_quest_dungeon_church:OnDeath(data)
	if IsServer() and self.parent then
		if data.unit:GetUnitName() == self.parent then
			self.receivedDmg = 0			
		end
	end
end


function modifier_quest_dungeon_church:OnTakeDamage(data)
	if IsServer() and self.parent then
		if data.unit == self.parent and data.attacker ~= "dungeon_boss_jeepers" then
			self.receivedDmg = self.receivedDmg + data.damage
			if self.receivedDmg >= self.thresholdDmg then
				self.receivedDmg = 0
				if self:GetStackCount() < CHARGES_FOR_CHURCH_DUNG then
					EmitSoundOn("Hero_LifeStealer.Infest", self.parent)
					ParticleManager:CreateParticle( "particles/items2_fx/soul_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
					self:IncrementStackCount()
				end
			end
		end
	end
end