-- 魂灵之影道具功能
-- 跟班道具，发射爆炸性泪弹

-- 评估魂灵之影缓存
---@param player EntityPlayer
function Ark_MOD:Item_Evaluate_Shadow_Revenant_Cache(player)
    local effects = player:GetEffects()
    local count = effects:GetCollectibleEffectNum(Ark.Item.Info.Shadow_Revenant) + player:GetCollectibleNum(Ark.Item.Info.Shadow_Revenant)
    local rng = RNG()
    local seed = math.max(Random(), 1)
    local rng_shift_index = 35
    rng:SetSeed(seed, rng_shift_index)
    player:CheckFamiliar(Ark.Item.Info.Shadow_Revenant_Variant, count, rng, Ark.Item.Info.Shadow_Revenant_Config)
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Evaluate_Shadow_Revenant_Cache, CacheFlag.CACHE_FAMILIARS)

-- 魂灵之影初始化
---@param familiar EntityFamiliar
function Ark_MOD:Item_Handle_Init_Shadow_Revenant(familiar)
    familiar:AddToFollowers()
    familiar:GetSprite():Play('aside')
end

Ark_MOD:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Ark_MOD.Item_Handle_Init_Shadow_Revenant, Ark.Item.Info.Shadow_Revenant_Variant)

-- 魂灵之影更新
---@param familiar EntityFamiliar
function Ark_MOD:Item_Handle_Update_Shadow_Revenant(familiar)
    local sprite = familiar:GetSprite()
    local player = familiar.Player
    local fire_direction = player:GetFireDirection()
    local direction
    local do_flip = false
    local shooting_tick_cooldown = math.random(35, 70)
    
    if fire_direction == Direction.LEFT then
        direction = Vector(-10, 0)
    elseif fire_direction == Direction.RIGHT then
        direction = Vector(10, 0)
    elseif fire_direction == Direction.DOWN then
        direction = Vector(0, 10)
    elseif fire_direction == Direction.UP then
        direction = Vector(0, -10)
    end
    
    if direction ~= nil and familiar.FireCooldown == 0 then
        local velocity = direction
        Isaac.Spawn(
            EntityType.ENTITY_TEAR,
            Ark.Item.Info.Shadow_Revenant_Bullt_Variant,
            0,
            familiar.Position,
            velocity,
            familiar
        ):ToTear()
        familiar.FireCooldown = shooting_tick_cooldown
        
        sprite.FlipX = do_flip
        sprite:Play("aside", true)
    end
    
    if sprite:IsFinished() then
        sprite:Play("aside")
    end
    
    familiar:FollowParent()
    familiar.FireCooldown = math.max(familiar.FireCooldown - 1, 0)
end

Ark_MOD:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Ark_MOD.Item_Handle_Update_Shadow_Revenant, Ark.Item.Info.Shadow_Revenant_Variant)

-- 魂灵之影泪弹碰撞
---@param entity_tear EntityTear
---@param entity Entity
function Ark_MOD:Item_Shadow_Revenant_Bullt(entity_tear, entity)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if entity_tear:CollidesWithGrid() or entity:IsEnemy() then
            Isaac.Explode(entity.Position, player, player.Damage * 7)
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, Ark_MOD.Item_Shadow_Revenant_Bullt, Ark.Item.Info.Shadow_Revenant_Bullt_Variant)
