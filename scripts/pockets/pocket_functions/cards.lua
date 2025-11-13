-- 卡牌功能

-- 生成苍蝇机器辅助函数
---@param num number
local function sp_ma(num)
    for i = 1, num do
        Game():Spawn(
            Ark.Enemy.Info.fly_machine,
            0,
            Game():GetRoom():GetCenterPos(),
            Vector(0, 0),
            nil,
            0,
            Game():GetRoom():GetSpawnSeed()
        )
    end
end

-- 机器卡牌使用
function Ark_MOD:Pocket_Machine()
    sp_ma(1)
end

Ark_MOD:AddCallback(ModCallbacks.MC_USE_CARD, Ark_MOD.Pocket_Machine, Ark.Pocket.Info.card_mach)

-- 工业卡牌使用
function Ark_MOD:Pocket_Industry()
    sp_ma(3)
end

Ark_MOD:AddCallback(ModCallbacks.MC_USE_CARD, Ark_MOD.Pocket_Industry, Ark.Pocket.Info.card_indu)
