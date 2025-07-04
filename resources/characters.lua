local w_Type = Isaac.GetPlayerTypeByName("w")
local wisadel_TYPE = Isaac.GetPlayerTypeByName("wisadel", true)
local W_hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/w_wis_hair.anm2")
local Shadow_Revenant = Isaac.GetItemIdByName("Shadow of Revenant")
local wis_tear = Isaac.GetEntityVariantByName("Shadow of Revenant bullt")
function Ark_mod:w_(player)
    if player:GetPlayerType() ~= w_Type then
        return
    end

    player:AddNullCostume(W_hairCostume)
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_mod.w_)

function Ark_mod:wisadel_(player)
    if player:GetPlayerType() ~= wisadel_TYPE then
        return
    end
    player:AddNullCostume(W_hairCostume)
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_mod.wisadel_)

function Ark_mod:w_wis_begin()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == wisadel_TYPE then
            if not player:HasCollectible(Shadow_Revenant) then
                player:AddCollectible(Shadow_Revenant)
            end
        end
        if player:GetPlayerType() == w_Type then
            if not player:HasCollectible(D12) then
                player:AddCollectible(D12)
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_mod.w_wis_begin,false)

function Ark_mod:wis_tears(tear)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == wisadel_TYPE then
            tear:ChangeVariant(wis_tear)
            tear.FallingAcceleration = 0
            tear.FallingSpeed = 0
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Ark_mod.wis_tears)