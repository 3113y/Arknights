-- 国王套装道具功能
-- 包括：国王的新枪、国王的延伸、国王的铠甲、诸王的冠冕

-- 国王的新枪 - 射速加成
---@param player EntityPlayer
function Ark_MOD:Item_New_Lance_Effect(player)
    local hearts = player:GetHearts()
    if player:HasCollectible(Ark.Item.Info.New_Lance) then
        local tears_to_add = 3
        if hearts <= 1 then
            Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_New_Lance_Effect, CacheFlag.CACHE_FIREDELAY)

-- 国王的延伸 - 进入新房间增加充能
function Ark_MOD:Item_Legacy_Effect()
    local player = Game():GetPlayer(0)
    local hearts = player:GetHearts()
    if player:HasCollectible(Ark.Item.Info.Legacy) then
        if hearts <= 1 then
            player:AddBloodCharge(1)
            player:AddSoulCharge(1)
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Ark_MOD.Item_Legacy_Effect)

-- 国王的铠甲 - 进入新房间转换红心为魂心
function Ark_MOD:Item_Armor_Effect()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        local hearts = player:GetHearts()
        if player:HasCollectible(Ark.Item.Info.Armor) then
            if hearts > 1 then
                player:AddHearts(-1)
                player:AddSoulHearts(1)
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Ark_MOD.Item_Armor_Effect)

-- 诸王的冠冕 - 伤害加成
---@param player EntityPlayer
---@param cache CacheFlag
function Ark_MOD:Item_Crown_Effect(player, cache)
    local hearts = player:GetHearts()
    local new_lance_count = player:GetCollectibleNum(Ark.Item.Info.New_Lance)
    local legacy_count = player:GetCollectibleNum(Ark.Item.Info.Legacy)
    local armor_count = player:GetCollectibleNum(Ark.Item.Info.Armor)
    local crown_count = player:GetCollectibleNum(Ark.Item.Info.Crown)
    local king_count = new_lance_count + legacy_count + armor_count + crown_count
    
    if player:HasCollectible(Ark.Item.Info.Crown) then
        if hearts < 2 then
            if king_count < 3 then
                player.Damage = player.Damage * 1.5
            elseif king_count >= 3 then
                player.Damage = player.Damage * 2.5
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Crown_Effect, CacheFlag.CACHE_DAMAGE)
