-- 金币系列道具功能
-- 包括：金杯、投币玩具、骑士戒律

-- 金币射速套装 - 统一处理
function Ark_MOD:Item_Coins_Tears()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local coins = player:GetNumCoins()
        local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
        
        -- 金杯
        if player:HasCollectible(Ark.Item.Info.Golden_Chalice) then
            local coefficient = Ark.Item.Table.difficulty_coefficients.golden_chalice[difficulty] or 0.05
            local tears_to_add = coins * coefficient
            Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
        end
        
        -- 投币玩具
        if player:HasCollectible(Ark.Item.Info.Coin_Operated) then
            local coefficient = Ark.Item.Table.difficulty_coefficients.coin_operated[difficulty] or 0.01
            local tears_to_add = coins * coefficient
            Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
        end
        
        -- 骑士戒律
        if player:HasCollectible(Ark.Item.Info.Chivalric_Commandments) then
            local coefficient = Ark.Item.Table.difficulty_coefficients.chivalric_commandments[difficulty] or 0.03
            local tears_to_add = coins * coefficient
            Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Coins_Tears, CacheFlag.CACHE_FIREDELAY)

-- 强制刷新属性（为了实时更新金币射速）
---@param player EntityPlayer
function Ark_MOD:Item_Force_Evaluate_Cache(player)
    Ark.Item.Function.Custom.Force_Evaluate_Cache(player)
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_MOD.Item_Force_Evaluate_Cache)
