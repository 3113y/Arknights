-- w 角色功能

-- w 初始化
---@param player EntityPlayer
function Ark_MOD:Character_w_Init(player)
    if player:GetPlayerType() ~= Ark.Character.Info.w_Type then
        return
    end
    player:AddNullCostume(Ark.Character.Info.W_hair_Costume)
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_MOD.Character_w_Init)

-- w 开局道具
function Ark_MOD:Character_w_Begin()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == Ark.Character.Info.w_Type then
            if not player:HasCollectible(Ark.Item.Info.D12) then
                player:AddCollectible(Ark.Item.Info.D12)
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_MOD.Character_w_Begin, false)

-- w 属性
---@param player EntityPlayer
---@param cache_flag CacheFlag
function Ark_MOD:Character_w_On_Cache(player, cache_flag)
    if player:GetName() == "w" then
        Ark.Character.Function.Custom.Apply_Stats_Template(player, cache_flag, Ark.Character.Table.Template)
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Character_w_On_Cache)

-- w 长子权
---@param player EntityPlayer
function Ark_MOD:Character_w_Birthright(player)
    if player:HasCollectible(619) then
        if player:GetPlayerType() == Ark.Character.Info.w_Type then
            if Ark.Character.Variable.Num.w_has_pri == 0 then
                Ark.Character.Variable.Num.w_has_pri = 1
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_MOD.Character_w_Birthright)

-- 移除 Keeper B 的金币道具
---@param player EntityPlayer
function Ark_MOD:Character_Remove_Coin_Items(player)
    if player:GetPlayerType() == PlayerType.PLAYER_KEEPER_B then
        Game():GetItemPool():RemoveCollectible(Ark.Item.Info.Antique_Coins)
        Game():GetItemPool():RemoveCollectible(Ark.Item.Info.Flawless_Jadestone)
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_MOD.Character_Remove_Coin_Items)
