-- 难度相关道具功能
-- 包括：凉拌海草、橘味风暴、咖啡糖、尖叫樱桃

-- 凉拌海草 - 射速加成（难度相关）
---@param player EntityPlayer
function Ark_MOD:Item_Seaweed_Salad(player)
    if player:HasCollectible(Ark.Item.Info.Seaweed_Salad) then
        local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
        local tears_to_add = Ark.Item.Table.difficulty_coefficients.seaweed_salad[difficulty] or 0.25
        Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Seaweed_Salad, CacheFlag.CACHE_FIREDELAY)

-- 橘味风暴 - 伤害加成（难度相关）
---@param player EntityPlayer
function Ark_MOD:Item_Orange_Storm(player)
    if player:HasCollectible(Ark.Item.Info.Orange_Storm) then
        local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
        local damage_multiplier = Ark.Item.Table.difficulty_coefficients.orange_storm[difficulty] or 1.05
        player.Damage = player.Damage * damage_multiplier
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Orange_Storm, CacheFlag.CACHE_DAMAGE)

-- 咖啡糖 - 射速加成（难度相关）
---@param player EntityPlayer
function Ark_MOD:Item_Coffee_Candy(player)
    if player:HasCollectible(Ark.Item.Info.Coffee_Candy) then
        local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
        local tears_to_add = Ark.Item.Table.difficulty_coefficients.coffee_candy[difficulty] or 0.3
        Ark.Item.Function.Custom.Tears_Modifier(player, tears_to_add)
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Coffee_Candy, CacheFlag.CACHE_FIREDELAY)

-- 尖叫樱桃 - 伤害加成（难度相关）
---@param player EntityPlayer
function Ark_MOD:Item_Screaming_Cherry(player)
    if player:HasCollectible(Ark.Item.Info.Screaming_Cherry) then
        local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
        local damage_multiplier = Ark.Item.Table.difficulty_coefficients.screaming_cherry[difficulty] or 1.07
        player.Damage = player.Damage * damage_multiplier
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Item_Screaming_Cherry, CacheFlag.CACHE_DAMAGE)
