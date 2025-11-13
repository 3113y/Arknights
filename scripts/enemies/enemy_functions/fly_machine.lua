-- 苍蝇机器敌人功能

-- 苍蝇机器更新
---@param fly_mach EntityNPC
function Ark_MOD:Enemy_FM_Update(fly_mach)
    local sprite = fly_mach:GetSprite()
    local target = fly_mach:GetPlayerTarget()
    local path = fly_mach.Pathfinder
    
    if fly_mach.State == NpcState.STATE_INIT then
        sprite:Play("Appear")
    end
    
    if sprite:IsFinished("Appear") then
        if path:HasPathToPos(target.Position, true) then
            fly_mach.State = NpcState.STATE_MOVE
        end
    end
    
    if fly_mach.State == NpcState.STATE_MOVE then
        sprite:Play("Move")
        fly_mach.Velocity = (target.Position - fly_mach.Position) * 0.5
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_NPC_UPDATE, Ark_MOD.Enemy_FM_Update, Ark.Enemy.Info.fly_machine)

-- 苍蝇机器攻击（碰撞）
---@param player EntityPlayer
---@param entity Entity
function Ark_MOD:Enemy_FM_Attack(player, entity)
    local cd_n = 15
    if player:GetNumCoins() >= 5 then
        if entity.Type == Ark.Enemy.Info.fly_machine then
            if Ark.Enemy.Variable.Num.fly_machine_cd == 0 then
                player:AddCoins(-5)
                Ark.Enemy.Variable.Num.fly_machine_cd = cd_n
            end
            Ark.Enemy.Variable.Num.fly_machine_cd = Ark.Enemy.Variable.Num.fly_machine_cd - 1
        end
    end
    return nil
end

Ark_MOD:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Ark_MOD.Enemy_FM_Attack)

-- 苍蝇机器死亡
---@param entity Entity
function Ark_MOD:Enemy_FM_Die(entity)
    if entity.Type == Ark.Enemy.Info.fly_machine then
        local coin = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COIN,
            2,
            entity.Position,
            Vector.Zero,
            entity
        )
        coin.Parent = entity
    end
end

Ark_MOD:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, Ark_MOD.Enemy_FM_Die)
