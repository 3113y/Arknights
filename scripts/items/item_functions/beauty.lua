-- 美愿道具功能
-- 开局生成，影响宝箱房道具池

-- 开局生成美愿
---@param _ any
---@param is_continue boolean
function Ark_MOD:Item_Ar_Beginning(_, is_continue)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if not is_continue then
            if not player:HasCollectible(Ark.Item.Info.Beauty) then
                Game():Spawn(
                    EntityType.ENTITY_PICKUP,
                    PickupVariant.PICKUP_COLLECTIBLE,
                    (Game():GetRoom():GetCenterPos() + Vector(-100, 0)),
                    Vector(0, 0),
                    nil,
                    Ark.Item.Info.Beauty,
                    Game():GetRoom():GetSpawnSeed()
                )
                if player:GetPlayerType() == 35 then
                    break
                end
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_MOD.Item_Ar_Beginning, false)

-- Tainted Lazarus 拾取美愿标记
---@param pickup EntityPickup
---@param collider Entity
---@param low boolean
function Ark_MOD:Item_Lazarus(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == 29 or player:GetPlayerType() == 38 then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Ark.Item.Info.Beauty then
                    if Ark.Item.Variable.Num.tainted_lazarus == 0 then
                        Ark.Item.Variable.Num.tainted_lazarus = 1
                    end
                end
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_MOD.Item_Lazarus)

-- 美愿效果 - 影响宝箱房道具池
function Ark_MOD:Item_Beauty_Effect()
    if Game():GetRoom():GetType() == RoomType.ROOM_TREASURE then
        for i = 0, Game():GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            local coins = player:GetNumCoins()
            local tags = Ark.Item.Table.transformation_tags
            local table_col = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
            local nums = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
            
            if player:HasCollectible(Ark.Item.Info.Beauty) or Ark.Item.Variable.Num.tainted_lazarus == 1 then
                -- 收集所有变身套装道具
                for col_i = 1, Isaac.GetItemConfig():GetCollectibles().Size - 1 do
                    if ItemConfig.Config.IsValidCollectible(col_i) then
                        for tag_i = 1, #tags do
                            if Isaac.GetItemConfig():GetCollectible(col_i):HasTags(tags[tag_i]) then
                                table.insert(table_col[tag_i], col_i)
                                if player:HasCollectible(col_i) then
                                    nums[tag_i] = nums[tag_i] + 1
                                end
                            end
                        end
                    end
                end
                
                -- 复制表格
                local table_del = Ark.Item.Function.Custom.Table_Copy(table_col)
                
                -- 国王套装
                local king = {
                    Ark.Item.Info.New_Lance,
                    Ark.Item.Info.Legacy,
                    Ark.Item.Info.Armor,
                    Ark.Item.Info.Crown
                }
                
                local hearts = player:GetHearts()
                
                -- 检查是否有1-2个同套装道具
                for num_i = 1, #nums do
                    if nums[num_i] == 1 or nums[num_i] == 2 then
                        -- 从列表中移除已拥有的道具
                        for _i = 1, #table_col[num_i] do
                            if player:HasCollectible(table_col[num_i][_i]) then
                                for _j = _i, #table_del[num_i] - 1 do
                                    table_del[num_i][_j] = table_del[num_i][_j + 1]
                                end
                                table_del[num_i][#table_del[num_i]] = nil
                            end
                        end
                        
                        -- 随机返回同套装的另一个道具
                        local _ret = Ark.Item.Function.Custom.Collectible_RNG(player, table_del[num_i][1], #table_del[num_i])
                        return table_del[num_i][_ret]
                    end
                end
                
                -- 低血量时返回国王套装
                if hearts <= 1 then
                    local king_ret_be = math.random(1, 4)
                    return king[king_ret_be]
                -- 高金币时返回金币套装
                elseif coins >= 50 then
                    if coins >= 80 then
                        return Ark.Item.Info.Golden_Chalice
                    else
                        local coins_ret = math.random(1, 2)
                        if coins_ret == 1 then
                            return Ark.Item.Info.Coin_Operated
                        else
                            return Ark.Item.Info.Chivalric_Commandments
                        end
                    end
                end
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Ark_MOD.Item_Beauty_Effect)
