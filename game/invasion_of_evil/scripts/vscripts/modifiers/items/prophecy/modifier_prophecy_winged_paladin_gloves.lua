
if modifier_prophecy_winged_paladin_gloves == nil then
    modifier_prophecy_winged_paladin_gloves = class({})
end

function modifier_prophecy_winged_paladin_gloves:IsHidden()
	return false
end

function modifier_prophecy_winged_paladin_gloves:GetTexture()
    return "custom_folder/prophecy/prophecy_winged_paladin_gloves"
end

function modifier_prophecy_winged_paladin_gloves:RemoveOnDeath()
	return false
end

function modifier_prophecy_winged_paladin_gloves:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH,
    }
    return funcs
end

function modifier_prophecy_winged_paladin_gloves:GetProphecyItemName()
	return "item_winged_paladin_gloves"
end


function modifier_prophecy_winged_paladin_gloves:OnCreated()
	if self:GetParent() then
		self:GetParent().mProphecyName = "modifier_prophecy_winged_paladin_gloves"
		self:GetParent().iProphecyName = "item_winged_paladin_gloves"
	end
end

--new_pos,process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate
--damage,ignore_invis,attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity
--heart_regen_applied,diffusal_applied,mkb_tested,no_attack_cooldown,damage_flags,original_damage
--gain,cost,basher_tested,distance

function modifier_prophecy_winged_paladin_gloves:OnDeath(data)
	if IsServer() and self:GetParent() then
		if data.unit:GetUnitName():find("dungeon_boss") then
			if data.attacker == self:GetParent() then
				if RollPercentage(100/#UNIQUE_ITEMS+PROPHECY_DROP_PERC) then
					data.attacker:EmitSound("Item.LotusOrb.Activate")
					SetProphecyItemName(self:GetProphecyItemName())
					self:Destroy()
				end
			end
		end
	end
end



function modifier_prophecy_winged_paladin_gloves:OnDestroy()
	if self:GetParent() then
		self:GetParent().mProphecyName = nil
		self:GetParent().iProphecyName = nil
	end
end