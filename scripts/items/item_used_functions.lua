-- 道具工具函数
-- 通用的工具函数，供各个道具功能使用

-- 射速计算函数
---@param player EntityPlayer
---@param value number 射速加成值
function Ark.Item.Function.Custom.Tears_Modifier(player, value)
    local fire_delay = player.MaxFireDelay
    local tears = 30 / (fire_delay + 1)
    local new_tears = tears + value
    local new_fire_delay = math.max((30 / new_tears) - 1, -0.99)
    player.MaxFireDelay = new_fire_delay
end

-- 复制 table 的函数，支持多维
---@param obj table
---@return table
function Ark.Item.Function.Custom.Table_Copy(obj)
    if type(obj) ~= "table" then
        return obj
    end
    local copy = {}
    -- 递归复制子 table
    for k, v in pairs(obj) do
        copy[k] = Ark.Item.Function.Custom.Table_Copy(v)
    end
    setmetatable(copy, getmetatable(obj))
    return copy
end

-- 随机数生成函数
---@param player EntityPlayer
---@param collectible CollectibleType
---@param number number
---@return number
function Ark.Item.Function.Custom.Collectible_RNG(player, collectible, number)
    if not player then return end
    local ran = player:GetCollectibleRNG(collectible):RandomInt(number) + 1
    return ran
end

-- 获取游戏难度
---@return Difficulty
function Ark.Item.Function.Custom.Get_Difficulty()
    return Game().Difficulty
end

-- 强制刷新玩家属性缓存
---@param player EntityPlayer
function Ark.Item.Function.Custom.Force_Evaluate_Cache(player)
    player:AddCacheFlags(CacheFlag.CACHE_PICKUP_VISION | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()
end
