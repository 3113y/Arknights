local fly_machine = Isaac.GetEntityTypeByName("Fly Machine")
function Ark_mod:FM_Update(fly_mach)
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

Ark_mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Ark_mod.FM_Update, fly_machine)
local cd = 0
function Ark_mod:FM_Attack(player, entity)
    local cd_n = 15
    if player:GetNumCoins() >= 5 then
        if entity.Type == fly_machine then
            if cd == 0 then
                player:AddCoins(-5)
                cd = cd_n
            end
            cd = cd - 1
        end
    end
    return nil
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Ark_mod.FM_Attack)
function Ark_mod:FM_dam()

end

function Ark_mod:FM_Die(entity)
    if entity.Type == fly_machine then
        local shockwave = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COIN,
            2,
            entity.Position,
            Vector.Zero,
            entity
        )
        shockwave.Parent = entity
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, Ark_mod.FM_Die)
