-- wisadel 角色功能

-- wisadel 初始化
---@param player EntityPlayer
function Ark_MOD:Character_wisadel_Init(player)
    if player:GetPlayerType() ~= Ark.Character.Info.wisadel_TYPE then
        return
    end
    player:AddNullCostume(Ark.Character.Info.W_hair_Costume)
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_MOD.Character_wisadel_Init)

-- wisadel 开局道具
function Ark_MOD:Character_wisadel_Begin()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == Ark.Character.Info.wisadel_TYPE then
            if not player:HasCollectible(Ark.Item.Info.Shadow_Revenant) then
                player:AddCollectible(Ark.Item.Info.Shadow_Revenant)
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_MOD.Character_wisadel_Begin, false)

-- wisadel 属性
---@param player EntityPlayer
---@param cache_flag CacheFlag
function Ark_MOD:Character_wisadel_On_Cache(player, cache_flag)
    if player:GetName() == "wisadel" then
        Ark.Character.Function.Custom.Apply_Stats_Template(player, cache_flag, Ark.Character.Table.Template)
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_MOD.Character_wisadel_On_Cache)

-- wisadel 泪弹
---@param tear EntityTear
function Ark_MOD:Character_wisadel_Tears(tear)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == Ark.Character.Info.wisadel_TYPE then
            tear:ChangeVariant(Ark.Character.Info.wis_tear)
            tear.FallingAcceleration = 0
            tear.FallingSpeed = 0
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Ark_MOD.Character_wisadel_Tears)

-- wisadel 长子权
---@param player EntityPlayer
function Ark_MOD:Character_wisadel_Birthright(player)
    if player:HasCollectible(619) then
        if player:GetPlayerType() == Ark.Character.Info.wisadel_TYPE then
            if Ark.Character.Variable.Num.wis_has_pri == 0 then
                player:AddCollectible(Ark.Item.Info.Shadow_Revenant)
                Ark.Character.Variable.Num.wis_has_pri = 1
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_MOD.Character_wisadel_Birthright)
