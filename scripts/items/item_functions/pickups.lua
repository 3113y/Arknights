-- 拾取物道具功能
-- 包括：古旧钱币、无瑕宝玉、管理员权限卡、摸摸券

-- 古旧钱币 - 拾取时给金币
---@param pickup EntityPickup
---@param collider Entity
---@param low boolean
function Ark_MOD:Item_Antique_Coins(pickup, collider, low)
    if collider.Type == EntityType.ENTITY_PLAYER then
        if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Ark.Item.Info.Antique_Coins then
            if Ark.Item.Variable.Num.mon_1 == 0 then
                local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
                local coins_to_add = Ark.Item.Table.difficulty_coefficients.antique_coins[difficulty] or 16
                Isaac.GetPlayer():AddCoins(coins_to_add)
                Ark.Item.Variable.Num.mon_1 = 1
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_MOD.Item_Antique_Coins)

-- 无瑕宝玉 - 拾取时给金币
---@param pickup EntityPickup
---@param collider Entity
---@param low boolean
function Ark_MOD:Item_Flawless_Jadestone(pickup, collider, low)
    if collider.Type == EntityType.ENTITY_PLAYER then
        if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Ark.Item.Info.Flawless_Jadestone then
            if Ark.Item.Variable.Num.mon_2 == 0 then
                local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
                local coins_to_add = Ark.Item.Table.difficulty_coefficients.flawless_jadestone[difficulty] or 25
                Isaac.GetPlayer():AddCoins(coins_to_add)
                Ark.Item.Variable.Num.mon_2 = 1
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_MOD.Item_Flawless_Jadestone)

-- 管理员权限卡 - 拾取时给金币和道具
---@param pickup EntityPickup
---@param collider Entity
---@param low boolean
function Ark_MOD:Item_Admin_Access_Card(pickup, collider, low)
    if collider.Type == EntityType.ENTITY_PLAYER then
        if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Ark.Item.Info.Admin_Access_Card then
            local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
            local coins_to_add = Ark.Item.Table.difficulty_coefficients.admin_access_card_coins[difficulty] or 0
            
            if coins_to_add > 0 then
                Isaac.GetPlayer():AddCoins(coins_to_add)
            end
            
            Game():Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_COLLECTIBLE,
                Game():GetRoom():GetCenterPos(),
                Vector(0, 0),
                nil,
                619,
                Game():GetRoom():GetSpawnSeed()
            )
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_MOD.Item_Admin_Access_Card)

-- 摸摸券 - 拾取时给魂心和道具
---@param pickup EntityPickup
---@param collider Entity
---@param low boolean
function Ark_MOD:Item_Petting_Ticket(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Ark.Item.Info.Petting_Ticket then
                    local difficulty = Ark.Item.Function.Custom.Get_Difficulty()
                    local souls_to_add = Ark.Item.Table.difficulty_coefficients.petting_ticket_souls[difficulty] or 0
                    
                    if souls_to_add > 0 then
                        player:AddSoulHearts(souls_to_add)
                    end
                    
                    Game():Spawn(
                        EntityType.ENTITY_PICKUP,
                        PickupVariant.PICKUP_COLLECTIBLE,
                        Game():GetRoom():GetCenterPos(),
                        Vector(0, 0),
                        nil,
                        619,
                        Game():GetRoom():GetSpawnSeed()
                    )
                end
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_MOD.Item_Petting_Ticket)

-- 开局重置拾取物变量
---@param _ any
---@param is_continue boolean
function Ark_MOD:Item_Beginning(_, is_continue)
    Ark.Item.Variable.Num.mon_1 = 0
    Ark.Item.Variable.Num.mon_2 = 0
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_MOD.Item_Beginning)
