
if modifier_bosses_autocast == nil then
    modifier_bosses_autocast = class({})
end

function modifier_bosses_autocast:IsHidden()
	return true
end

function modifier_bosses_autocast:GetTexture()
    return "nevermore_dark_lord"
end

function modifier_bosses_autocast:RemoveOnDeath()
	return true
end

function modifier_bosses_autocast:DeclareFunctions()
    return nil
end

function modifier_bosses_autocast:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.abilityTable = {}
        for i = 0, 6 do
            ability = self.caster:GetAbilityByIndex(i)
            if ability then
            	if ability:GetCooldown(1) > 1 then
					table.insert(self.abilityTable,ability)
				end
            end
        end
        self.number = 1
		self:StartIntervalThink(15.0) 
	end
end

function modifier_bosses_autocast:OnIntervalThink()
	if self:GetCaster() then
		if self.abilityTable then
			if self.number > #self.abilityTable then
				self.number = 1
			end

			local ability = self.abilityTable[self.number]
			if ability:IsCooldownReady() then
				ability:CastAbility()
				self.number = self.number + 1
			end

		end
	end
end