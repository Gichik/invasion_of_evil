
if modifier_alchemy == nil then
    modifier_alchemy = class({})
end

function modifier_alchemy:IsHidden()
	return false
end

function modifier_alchemy:GetTexture()
	return "alchemist_unstable_concoction"
end

function modifier_alchemy:RemoveOnDeath()
	return false
end

function modifier_alchemy:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
    }
    return funcs
end


function modifier_alchemy:OnCreated()
	self.combination = ""
end


--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_alchemy:OnDeath(data)
	if IsServer() and self:GetParent() then
		if data.unit:GetUnitName() == "npc_bush" then
			if data.attacker == self:GetParent() then

				if data.unit:HasModifier("modifier_color_red") then
					self.combination = self.combination .. "r"
				end

				if data.unit:HasModifier("modifier_color_green") then
					self.combination = self.combination .. "g"
				end

				if data.unit:HasModifier("modifier_color_blue") then
					self.combination = self.combination .. "b"
				end				

				self:IncrementStackCount()


				if self:GetStackCount() >= 3 then
					self:SetStackCount(0)
					self:RemoveAlchemyBuff()
					self:ApplyAlchemyBuff(self.combination)
					self.combination = ""
				else
					EmitSoundOn("DOTA_Item.Tango.Activate", data.unit)
				end

			end
		end
	end
end

function modifier_alchemy:ApplyAlchemyBuff(combination)
	--Если это кто-то читает, то позволь оправдаться перед самим собой тем, что я торопился.
	if self:GetCaster() then
	--print("------ApplyAlchemyBuff-------")
	--print(combination)
		if combination == "rrr" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_hp_regen_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "ggg" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_health_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "bbb" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_mp_regen_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "rrg" or combination == "rgr" or combination == "grr" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_damage_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "rrb" or combination == "rbr" or combination == "brr" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_movement_speed_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "ggr" or combination == "grg" or combination == "rgg" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_armor_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "ggb" or combination == "gbg" or combination == "bgg" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_accuracy_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "bbr" or combination == "brb" or combination == "rbb" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_magic_resist_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		if combination == "bbg" or combination == "bgb" or combination == "gbb" then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_attack_speed_buff", {duration = 180})
			EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end


		if combination == "rgb" or combination == "rbg" 
			or combination == "grb" or combination == "gbr"
			or combination == "brg" or combination == "bgr" then
				self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_poisoning_debuff", {duration = 180})
				EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster())
			return nil
		end

		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemy_fail_buff", {duration = 180})
		EmitSoundOn("DOTA_Item.MagicStick.Activate", self:GetCaster())

	end
end

function modifier_alchemy:RemoveAlchemyBuff()
	if self:GetCaster() then
	--print("------RemoveAlchemyBuff-------")		
		local caster = self:GetCaster()
		caster:RemoveModifierByName("modifier_alchemy_fail_buff")
		caster:RemoveModifierByName("modifier_alchemy_hp_regen_buff")
		caster:RemoveModifierByName("modifier_alchemy_health_buff")
		caster:RemoveModifierByName("modifier_alchemy_mp_regen_buff")
		caster:RemoveModifierByName("modifier_alchemy_damage_buff")
		caster:RemoveModifierByName("modifier_alchemy_movement_speed_buff")
		caster:RemoveModifierByName("modifier_alchemy_armor_buff")
		caster:RemoveModifierByName("modifier_alchemy_accuracy_buff")
		--caster:RemoveModifierByName("modifier_alchemy_evasion_buff")
		caster:RemoveModifierByName("modifier_alchemy_magic_resist_buff")	
		caster:RemoveModifierByName("modifier_alchemy_attack_speed_buff")
		caster:RemoveModifierByName("modifier_alchemy_poisoning_debuff")

	end
end