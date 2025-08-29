itemConfig = Isaac.GetItemConfig()
New_Lance = Isaac.GetItemIdByName("King's New Lance")
Legacy = Isaac.GetItemIdByName("King's Legacy")
Armor = Isaac.GetItemIdByName("King's Armor")
Crown = Isaac.GetItemIdByName("King's Crown")
Beauty = Isaac.GetItemIdByName("Nostalgia of Beauty")
Hatred = Isaac.GetItemIdByName("Talons of Hatred")
Golden_Chalice = Isaac.GetItemIdByName("Golden Chalice")
Coin_Operated = Isaac.GetItemIdByName("Coin-Operated Toy")
Chivalric_Commandments = Isaac.GetItemIdByName("Chivalric Commandments - New Edition")
Seaweed_Salad = Isaac.GetItemIdByName("Seaweed Salad")
Orange_Storm = Isaac.GetItemIdByName("Orange Storm")
Coffee_Candy = Isaac.GetItemIdByName("Coffee Plains Coffee Candy")
Screaming_Cherry = Isaac.GetItemIdByName("Screaming Cherry")
Antique_Coins = Isaac.GetItemIdByName("Antique Coins")
Flawless_Jadestone = Isaac.GetItemIdByName("Flawless Jadestone")
Admin_Access_Card = Isaac.GetItemIdByName("Game Room Admin Access Card")
Petting_Ticket = Isaac.GetItemIdByName("Ms. Christine Petting Ticket")
Shadow_Revenant = Isaac.GetItemIdByName("Shadow of Revenant")
D12 = Isaac.GetItemIdByName("D12")
CONFIG_Shadow_Revenant = itemConfig:GetCollectible(Shadow_Revenant)
Shadow_Revenant_VARIANT = Isaac.GetEntityVariantByName("Shadow of Revenant")
Shadow_Revenant_Bullt_VARIANT = Isaac.GetEntityVariantByName("Shadow of Revenant bullt")
local wisadel_TYPE = Isaac.GetPlayerTypeByName("wisadel", true)
local w_Type = Isaac.GetPlayerTypeByName("w")
local mon_1 = 0
local mon_2 = 0
local w_has_pri = 0
local wis_has_pri = 0
local Tainted_Lazarus = 0
--获取游戏难度
function Ark_mod.DIF()
    Game_dif = Game().Difficulty
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Ark_mod.DIF)
--射速计算
function TearsModifier(player, value)
    local fireDelay = player.MaxFireDelay
    local tears = 30 / (fireDelay + 1)
    local newtears = tears + value
    local newfiredelay = math.max((30 / newtears) - 1, -0.99)
    player.MaxFireDelay = newfiredelay
end

-- 复制table的函数，支持多维
function Table_Copy(obj)
    if type(obj) ~= "table" then
        return obj
    end
    local copy = {}
    -- 递归复制子 table
    for k, v in pairs(obj) do
        copy[k] = Table_Copy(v)
    end
    setmetatable(copy, getmetatable(obj))
    return copy
end

function CollectibleRNG(player, Collectible, number) --随机
    if not player then return end
    local ran = player:GetCollectibleRNG(Collectible):RandomInt(number) + 1
    return ran
end

--开局生成美愿
function Ark_mod:Ar_Beginning(_, bool)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if not bool then
            if not player:HasCollectible(Beauty) then
                Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
                    (Game():GetRoom():GetCenterPos() + Vector(-100, 0)),
                    Vector(0, 0), nil, Beauty, Game():GetRoom():GetSpawnSeed())
                if player:GetPlayerType() == 35 then
                    break
                end
            end
        end
    end
    mon_1 = 0
    mon_2 = 0
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_mod.Ar_Beginning, false)
--国王的新枪
function Ark_mod:New_Lance_Effect(player)
    local hearts = player:GetHearts()
    if player:HasCollectible(New_Lance) then
        local TearsToAdd = 3
        if hearts <= 1 then
            TearsModifier(player, TearsToAdd)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.New_Lance_Effect, CacheFlag.CACHE_FIREDELAY)
--国王的延伸
function Ark_mod:Legacy_Effect()
    local player = Game():GetPlayer(0)
    local hearts = player:GetHearts()
    if player:HasCollectible(Legacy) then
        if hearts <= 1 then
            player:AddBloodCharge(1)
            player:AddSoulCharge(1)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Ark_mod.Legacy_Effect)
--国王的铠甲
function Ark_mod:Armor_Effect()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        local hearts = player:GetHearts()
        if player:HasCollectible(Armor) then
            if hearts > 1 then
                player:AddHearts(-1)
                player:AddSoulHearts(1)
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Ark_mod.Armor_Effect)
--诸王的冠冕
function Ark_mod:Crown_Effect(player, cache)
    local hearts = player:GetHearts()
    New_Lance_Count = player:GetCollectibleNum(New_Lance)
    Legacy_Count = player:GetCollectibleNum(Legacy)
    Armor_Count = player:GetCollectibleNum(Armor)
    Crown_Count = player:GetCollectibleNum(Crown)
    King_Count = New_Lance_Count + Legacy_Count + Armor_Count + Crown_Count
    if player:HasCollectible(Crown) then
        if hearts < 2 then
            if King_Count < 3 then
                player.Damage = player.Damage * 1.5
            elseif King_Count >= 3 then
                player.Damage = player.Damage * 2.5
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Crown_Effect, CacheFlag.CACHE_DAMAGE)
--死仇
--[[
function mod:Hatred_Effect(player)
    if player:HasCollectible(Hatred) then
        player.Damage = player.Damage * 0.8
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Hatred_Effect)
]]
--钱泪攻速套
function Ark_mod:Coins_Tears()
    local num_golden = 0.05
    local num_coin_operated = 0.01
    local num_chivalric_commandments = 0.03
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local coins = player:GetNumCoins()
        local TearsToAdd_golden = coins * num_golden
        local TearsToAdd_coin_operated = coins * num_coin_operated
        local TearsToAdd_commandments = coins * num_chivalric_commandments
        if player:HasCollectible(Golden_Chalice) then
            TearsModifier(player, TearsToAdd_golden)
        end
        if player:HasCollectible(Coin_Operated) then
            TearsModifier(player, TearsToAdd_coin_operated)
        end
        if player:HasCollectible(Chivalric_Commandments) then
            TearsModifier(player, TearsToAdd_commandments)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Coins_Tears, CacheFlag.CACHE_FIREDELAY)
--强制刷新属性
function Ark_mod:ForceEvaluateCache(player)
    player:AddCacheFlags(CacheFlag.CACHE_PICKUP_VISION| CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_mod.ForceEvaluateCache)
--凉拌海草
function Ark_mod:Seaweed_Salad(player)
    if player:HasCollectible(Seaweed_Salad) then
        if Game_dif == 1 or Game_dif == 3 then
            TearsModifier(player, 0.5)
        elseif Game_dif == 0 or Game_dif == 2 then
            TearsModifier(player, 0.25)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Seaweed_Salad, CacheFlag.CACHE_FIREDELAY)
--橘味风暴
function Ark_mod:Orange_Storm(player)
    if player:HasCollectible(Orange_Storm) then
        if Game_dif == 1 or Game_dif == 3 then
            player.Damage = player.Damage * 1.1
        elseif Game_dif == 0 or Game_dif == 2 then
            player.Damage = player.Damage * 1.05
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Orange_Storm, CacheFlag.CACHE_DAMAGE)
--咖啡糖
function Ark_mod:Coffee_Candy(player)
    if player:HasCollectible(Coffee_Candy) then
        if Game_dif == 1 or Game_dif == 3 then
            TearsModifier(player, 0.6)
        elseif Game_dif == 0 or Game_dif == 2 then
            TearsModifier(player, 0.3)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Coffee_Candy, CacheFlag.CACHE_FIREDELAY)
--尖叫樱桃
function Ark_mod:Screaming_Cherry(player)
    if player:HasCollectible(Screaming_Cherry) then
        if Game_dif == 1 or Game_dif == 3 then
            player.Damage = player.Damage * 1.15
        elseif Game_dif == 0 or Game_dif == 2 then
            player.Damage = player.Damage * 1.07
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Screaming_Cherry, CacheFlag.CACHE_DAMAGE)

--古旧钱币
function Ark_mod:Antique_Coins(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Antique_Coins then
                    if mon_1 == 0 then
                        if Game_dif == 1 or Game_dif == 3 then
                            Isaac.GetPlayer():AddCoins(20)
                        elseif Game_dif == 0 or Game_dif == 2 then
                            Isaac.GetPlayer():AddCoins(16)
                        end
                        mon_1 = 1
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Antique_Coins)
--无瑕宝玉
function Ark_mod:Flawless_Jadestone(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Flawless_Jadestone then
                    if mon_2 == 0 then
                        if Game_dif == 1 or Game_dif == 3 then
                            Isaac.GetPlayer():AddCoins(30)
                        elseif Game_dif == 0 or Game_dif == 2 then
                            Isaac.GetPlayer():AddCoins(25)
                        end
                        mon_2 = 1
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Flawless_Jadestone)
--管理员权限卡
function Ark_mod:Admin_Access_Card(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Admin_Access_Card then
                    if Game_dif == 1 or Game_dif == 3 then
                        Isaac.GetPlayer():AddCoins(3)
                        Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
                            Game():GetRoom():GetCenterPos(), Vector(0, 0), nil, 619, Game():GetRoom():GetSpawnSeed())
                    elseif Game_dif == 0 or Game_dif == 2 then
                        Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
                            Game():GetRoom():GetCenterPos(), Vector(0, 0), nil, 619, Game():GetRoom():GetSpawnSeed())
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Admin_Access_Card)
--摸摸券
function Ark_mod:Petting_Ticket(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Petting_Ticket then
                    if Game_dif == 1 or Game_dif == 3 then
                        player:AddSoulHearts(2)
                        Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
                            Game():GetRoom():GetCenterPos(), Vector(0, 0), nil, 619, Game():GetRoom():GetSpawnSeed())
                    elseif Game_dif == 0 or Game_dif == 2 then
                        Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
                            Game():GetRoom():GetCenterPos(), Vector(0, 0), nil, 619, Game():GetRoom():GetSpawnSeed())
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Petting_Ticket)
--魂灵之影
function Ark_mod:Evaluate_Shadow_Revenant_Cache(player)
    local effects = player:GetEffects()
    local count = effects:GetCollectibleEffectNum(Shadow_Revenant) + player:GetCollectibleNum(Shadow_Revenant)
    local rng = RNG()
    local seed = math.max(Random(), 1)
    local RNG_SHIFT_INDEX = 35
    rng:SetSeed(seed, RNG_SHIFT_INDEX)
    player:CheckFamiliar(Shadow_Revenant_VARIANT, count, rng, CONFIG_Shadow_Revenant)
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Evaluate_Shadow_Revenant_Cache, CacheFlag.CACHE_FAMILIARS)
function Ark_mod:HandleInit_Shadow_Revenant(familiar)
    familiar:AddToFollowers()
    familiar:GetSprite():Play('aside')
end

Ark_mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Ark_mod.HandleInit_Shadow_Revenant, Shadow_Revenant_VARIANT)
function Ark_mod:HandleUpdate_Shadow_Revenant(familiar)
    local sprite = familiar:GetSprite()
    local player = familiar.Player
    local fireDirection = player:GetFireDirection()
    local direction
    local doFlip = false
    local SHOOTING_TICK_COOLDOWN = math.random(35, 70)
    if fireDirection == Direction.LEFT then
        direction = Vector(-10, 0)
    elseif fireDirection == Direction.RIGHT then
        direction = Vector(10, 0)
    elseif fireDirection == Direction.DOWN then
        direction = Vector(0, 10)
    elseif fireDirection == Direction.UP then
        direction = Vector(0, -10)
    end
    if direction ~= nil and familiar.FireCooldown == 0 then
        Velocity = direction
        Isaac.Spawn(
            EntityType.ENTITY_TEAR,
            Shadow_Revenant_Bullt_VARIANT,
            0,
            familiar.Position,
            Velocity,
            familiar
        ):ToTear()
        familiar.FireCooldown = SHOOTING_TICK_COOLDOWN

        sprite.FlipX = doFlip
        sprite:Play("aside", true)
    end
    if sprite:IsFinished() then
        sprite:Play("aside")
    end
    familiar:FollowParent()
    familiar.FireCooldown = math.max(familiar.FireCooldown - 1, 0)
end

Ark_mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Ark_mod.HandleUpdate_Shadow_Revenant, Shadow_Revenant_VARIANT)
--魂灵之影泪弹
function Ark_mod:Shadow_Revenant_Bullt(EntityTear, Entity)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if EntityTear:CollidesWithGrid() or Entity:IsEnemy() then
            Isaac.Explode(Entity.Position, player, player.Damage * 7)
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, Ark_mod.Shadow_Revenant_Bullt, Shadow_Revenant_Bullt_VARIANT)

--D12
function Ark_mod:D12(_, _, player)
    if player:HasCollectible(D12) then
        for _, ent in pairs(Isaac.GetRoomEntities()) do
            if ent:IsEnemy() and ent:IsVulnerableEnemy() and not ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
                local AIM_pos = ent.Position
                local bomb = player:FireBomb(
                    AIM_pos,      -- 位置
                    Vector(0, 0), -- 速度
                    nil           -- 父实体
                )
                bomb:AddTearFlags(player:GetBombFlags())
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_USE_ITEM, Ark_mod.D12)
--属性池
local Template = {
    SPEED = 0.75,
    FIREDELAY = 10,
    DAMAGE = 0.50,
    RANGE = 260,
    SHOTSPEED = 1.00,
    LUCK = 2.00,
    TEARHEIGHT = 0.00,
    TEARFALLINGSPEED = 0.00,
    TEARFLAG = 0,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0),
    FLYING = false
}
--W数值
function Ark_mod:w_onCache(player, cacheFlag)
    if player:GetName() == "w" then
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed - 0.85 + Template.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - 10 + Template.FIREDELAY
        end
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage - 0.8 + Template.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange - 260 + Template.RANGE
            player.TearHeight = player.TearHeight + Template.TEARHEIGHT
            player.TearFallingSpeed = player.TearFallingSpeed + Template.TEARFALLINGSPEED
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed - 1 + Template.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + Template.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | Template.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = Template.TEARCOLOR
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and Template.FLYING then
            player.CanFly = true
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.w_onCache)
--维什戴尔数值
function Ark_mod:wis_onCache(player, cacheFlag)
    if player:GetName() == "wisadel" then
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed - 0.85 + Template.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay + Template.FIREDELAY
        end
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage - 0.8 + Template.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange - 260 + Template.RANGE
            player.TearHeight = player.TearHeight + Template.TEARHEIGHT
            player.TearFallingSpeed = player.TearFallingSpeed + Template.TEARFALLINGSPEED
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed - 1 + Template.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + Template.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | Template.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = Template.TEARCOLOR
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and Template.FLYING then
            player.CanFly = true
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.wis_onCache)
--两人长子权
function Ark_mod:w_wis_pri(player)
    if player:HasCollectible(619) then
        if player:GetPlayerType() == w_Type then
            if w_has_pri == 0 then                w_has_pri = 1
            end
        elseif player:GetPlayerType() == wisadel_TYPE then
            if wis_has_pri == 0 then
                player:AddCollectible(Shadow_Revenant)
                wis_has_pri = 1
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_mod.w_wis_pri)
function Ark_mod:Lazarus(pickup, collider, low)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetPlayerType() == 29 or player:GetPlayerType() == 38 then
            if collider.Type == EntityType.ENTITY_PLAYER then
                if pickup.Type == 5 and pickup.Variant == 100 and pickup.SubType == Beauty then
                    if Tainted_Lazarus == 0 then
                        Tainted_Lazarus = 1
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Lazarus)

--美愿
function Ark_mod:Beauty_Effect()
    if Game():GetRoom():GetType() == RoomType.ROOM_TREASURE then
        for i = 0, Game():GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            local coins = player:GetNumCoins()
            local Tags = {
                ItemConfig.TAG_GUPPY,
                ItemConfig.TAG_BABY,
                ItemConfig.TAG_DEVIL,
                ItemConfig.TAG_ANGEL,
                ItemConfig.TAG_SYRINGE,
                ItemConfig.TAG_BOOK,
                ItemConfig.TAG_FLY,
                ItemConfig.TAG_MOM,
                ItemConfig.TAG_MUSHROOM,
                ItemConfig.TAG_POOP,
                ItemConfig.TAG_BOB,
                ItemConfig.TAG_SPIDER
            }
            local table_col = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
            local nums = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
            if player:HasCollectible(Beauty) or Tainted_Lazarus == 1 then
                for col_i = 1, Isaac.GetItemConfig():GetCollectibles().Size - 1 do
                    if ItemConfig.Config.IsValidCollectible(col_i) then
                        for tag_i = 1, #Tags do
                            if Isaac.GetItemConfig():GetCollectible(col_i):HasTags(Tags[tag_i]) then
                                table.insert(table_col[tag_i], col_i)
                                if player:HasCollectible(col_i) then
                                    nums[tag_i] = nums[tag_i] + 1
                                end
                            end
                        end
                    end
                end
                local table_del = Table_Copy(table_col)
                local king = { New_Lance, Legacy, Armor, Crown } --国王套
                local hearts = player:GetHearts()
                for num_i = 1, #nums do
                    if nums[num_i] == 1 or nums[num_i] == 2 then
                        for _i = 1, #table_col[num_i] do
                            if player:HasCollectible(table_col[num_i][_i]) then
                                for _j = _i, #table_del[num_i] - 1 do
                                    table_del[num_i][_j] = table_del[num_i][_j + 1]
                                end
                                table_del[num_i][#table_del[num_i]] = nil
                            end
                        end
                        local _ret = CollectibleRNG(player, table_del[num_i][1], #table_del[num_i])
                        return table_del[num_i][_ret]
                    end
                end
                if hearts <= 1 then
                    local king_ret_be = math.random(1, 4)
                    return king[king_ret_be]
                elseif coins >= 50 then
                    if coins >= 80 then
                        return (Golden_Chalice)
                    else
                        local coins_ret = math.random(1, 2)
                        if coins_ret == 1 then
                            return (Coin_Operated)
                        else
                            return (Chivalric_Commandments)
                        end
                    end
                end
            end
        end
    end
end

Ark_mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Ark_mod.Beauty_Effect)


--[[Ark_mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
for i = 0, Game():GetLevel():GetRooms().Size-1 do
        local roomdesc = Game():GetLevel():GetRooms():Get(i)
        if roomdesc and roomdesc.Data then
            if roomdesc.Data.Type == RoomType.ROOM_BOSS then
                if not BossNameToChinese[(RemoveCopySuffix(roomdesc.Data.Name))] then
                    print("未翻译Boss: " .. (RemoveCopySuffix(roomdesc.Data.Name)))
                else
                    print("已翻译Boss: " ..
                        (RemoveCopySuffix(roomdesc.Data.Name)) ..
                        " -> " .. BossNameToChinese[(RemoveCopySuffix(roomdesc.Data.Name))])
                end
            end
        end
    end
end)
BossNameToChinese = {
    ["Monstro"] = "萌死戳",
    ["Larry Jr."] = "拉里子虫",
    ["Chub"] = "空心虫",
    ["Gurdy"] = "肉山",
    ["Monstro II"] = "萌死戳 II",
    ["Mom"] = "妈妈",
    ["Scolex"] = "头节虫",
    ["Mom's Heart"] = "妈妈的心脏",
    ["Famine"] = "饥荒骑士",
    ["Pestilence"] = "瘟疫骑士",
    ["War"] = "战争骑士",
    ["Death"] = "死亡骑士",
    ["The Duke of Flies"] = "苍蝇公爵",
    ["Peep"] = "嘘嘘怪",
    ["Loki"] = "洛基",
    ["Blastocyst"] = "囊胚",
    ["Gemini"] = "连体双子",
    ["Fistula"] = "瘘管团",
    ["Gish"] = "吉什",
    ["Steven"] = "史蒂文",
    ["C.H.A.D."] = "查德",
    ["Headless Horseman"] = "无头骑士",
    ["The Fallen"] = "堕落恶魔",
    ["Satan"] = "撒旦",
    ["It Lives!"] = "它还活着",
    ["The Hollow"] = "空心虫",
    ["The Carrion Queen"] = "腐蛆女王",
    ["Gurdy Jr."] = "小肉山",
    ["The Husk"] = "尸壳",
    ["The Bloat"] = "充血怪",
    ["Lokii"] = "分身洛基",
    ["The Blighted Ovum"] = "凋零双子",
    ["Teratoma"] = "中型畸胎瘤",
    ["Widow"] = "灰寡妇蛛",
    ["Mask of Infamy"] = "耻辱假面",
    ["The Wretched"] = "伤痕寡妇蛛",
    ["Pin"] = "钉头虫",
    ["Conquest"] = "征服骑士",
    ["Isaac"] = "以撒",
    ["???"] = "???",
    ["Daddy Long Legs"] = "长腿蛛父",
    ["Triachnid"] = "三腿蜘蛛",
    ["Haunt"] = "大恶灵",
    ["Haunt 2"] = "被遗弃者",
    ["Dingle"] = "坨坨",
    ["Dingle 2"] = "布朗尼",
    ["Mega Maw"] = "超级大嘴头",
    ["The Gate"] = "守门骷髅",
    ["Mega Fatty"] = "超级肥仔",
    ["The Cage"] = "大肥笼",
    ["Mama Gurdy"] = "母体肉山",
    ["Dark One"] = "黑暗恶魔",
    ["The Adversary"] = "敌手",
    ["Polycephalus"] = "多头畸胎",
    ["Mr. Fred"] = "大弗莱德",
    ["The Lamb"] = "羔羊",
    ["Mega Satan"] = "超级撒旦",
    ["Gurglings"] = "肉山幼崽",
    ["the stain"] = "血痕畸胎",
    ["Brownie"] = "布朗尼",
    ["The Forsaken"] = "被遗弃者",
    ["Little Horn"] = "小角恶魔",
    ["Ragman"] = "破布人",
    ["Ultra Greed"] = "究极贪婪",
    ["???(Alt)"] = "???(变种)",
    ["Dangle"] = "滑坨坨",
    ["Turdling"] = "粪山幼崽",
    ["Frail"] = "脆皮虫",
    ["Rag Mega"] = "超级绷带人",
    ["Vis Sisters"] = "开膛姐妹",
    ["Big Horn"] = "巨角恶魔",
    ["Delirium"] = "精神错乱",
    ["Ultra Greedier"] = "终极大贪婪",
    ["Matriarch"] = "胖蛆族母",
    ["The Pile"] = "骨堆畸胎",
    ["Reap Creep"] = "裂面爬墙蛛",
    ["Beelzeblub"] = "别西卜",
    ["Wormwood"] = "茵陈",
    ["Rainmaker"] = "造雨人",
    ["The Visage"] = "锁链假面",
    ["Siren"] = "塞壬",
    ["Tuff Twins"] = "灰岩子虫",
    ["The Heretic"] = "大异端",
    ["Hornfel"] = "岩角恶魔",
    ["Great Gideon"] = "大基甸",
    ["Baby Plum"] = "糖梅宝宝",
    ["Scourge"] = "鞭刃怪",
    ["Chimera"] = "嵌体怪",
    ["Rotgut"] = "腐脏巨面",
    ["Min Min"] = "冥明火灵",
    ["Clog"] = "拦路屎",
    ["Singe"] = "焦皮小子",
    ["Bumbino"] = "大乞丐宝",
    ["Colostomia"] = "结肠造口袋",
    ["The Shell"] = "枯壳虫",
    ["Turdlet"] = " 虫形大便",
    ["Raglich"] = "绷带巫妖",
    ["Dogma"] = "教条",
    ["The Beast"] = "祸兽",
    ["Horny Boys"] = "魔角兄弟",
    ["Clutch"] = "附身邪鬼",
    ["Mother"] = "母亲",
    ["Boss Room"] = "???",
    ["Mom (mausoleum)"] = "妈妈 (陵墓)",
    ["Double Trouble"] = "坏事成双"
}
function RemoveCopySuffix(name)
    -- 去除末尾的" (copy)"，不区分大小写
    return string.gsub(name, "%s*%(copy%)$", "")
end]]