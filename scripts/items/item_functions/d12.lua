-- D12 主动道具功能
-- 对所有敌人位置生成炸弹

-- D12 使用效果
---@param _ CollectibleType
---@param rng RNG
---@param player EntityPlayer
function Ark_MOD:Item_D12(_, rng, player)
    if player:HasCollectible(Ark.Item.Info.D12) then
        for _, ent in pairs(Isaac.GetRoomEntities()) do
            if ent:IsEnemy() and ent:IsVulnerableEnemy() and not ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
                local aim_pos = ent.Position
                local bomb = player:FireBomb(
                    aim_pos,      -- 位置
                    Vector(0, 0), -- 速度
                    nil           -- 父实体
                )
                bomb:AddTearFlags(player:GetBombFlags())
            end
        end
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_USE_ITEM, Ark_MOD.Item_D12, Ark.Item.Info.D12)
