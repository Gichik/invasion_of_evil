
if modifier_summoner_deep_knowledge == nil then
    modifier_summoner_deep_knowledge = class({})
end

function modifier_summoner_deep_knowledge:IsHidden()
	return true
end

function modifier_summoner_deep_knowledge:RemoveOnDeath()
	return false
end

function modifier_summoner_deep_knowledge:IsPurgable()
    return false
end

function modifier_summoner_deep_knowledge:IsPurgeException()
    return false
end

function modifier_summoner_deep_knowledge:GetTexture()
    return "keeper_of_the_light_blinding_light"
end

function modifier_summoner_deep_knowledge:DeclareFunctions()
    return nil
end

function modifier_summoner_deep_knowledge:OnCreated()
    --print("created")
    if self:GetCaster() and self:GetAbility() then
        self:GetCaster().reduceCD = self:GetAbility():GetSpecialValueFor("reduce_cooldown")
    end
end

function modifier_summoner_deep_knowledge:OnRefresh()
    --print("refresh")
    if self:GetCaster() and self:GetAbility() then
        self:GetCaster().reduceCD = self:GetAbility():GetSpecialValueFor("reduce_cooldown")
    end
end