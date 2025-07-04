local card_mach = Isaac.GetCardIdByName("machine")
local card_indu = Isaac.GetCardIdByName("industry")
local fly_machine = Isaac.GetEntityTypeByName("Fly Machine")
local function sp_ma(num)
    for i = 1, num do
        Game():Spawn(fly_machine,
            0,
            Game():GetRoom():GetCenterPos(),
            Vector(0, 0),
            nil,
            0,
            Game():GetRoom():GetSpawnSeed()
        )
    end
end
function Ark_mod:machine()
    sp_ma(1)
end

Ark_mod:AddCallback(ModCallbacks.MC_USE_CARD, Ark_mod.machine, card_mach)
function Ark_mod:industry()
    sp_ma(3)
end

Ark_mod:AddCallback(ModCallbacks.MC_USE_CARD, Ark_mod.industry, card_indu)
