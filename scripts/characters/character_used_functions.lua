-- 角色工具函数
-- 通用的角色相关工具函数

-- 应用角色属性模板
---@param player EntityPlayer
---@param cache_flag CacheFlag
---@param template table
function Ark.Character.Function.Custom.Apply_Stats_Template(player, cache_flag, template)
    if cache_flag == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed - 0.85 + template.SPEED
    end
    if cache_flag == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay - 10 + template.FIREDELAY
    end
    if cache_flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage - 0.8 + template.DAMAGE
    end
    if cache_flag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange - 260 + template.RANGE
        player.TearHeight = player.TearHeight + template.TEARHEIGHT
        player.TearFallingSpeed = player.TearFallingSpeed + template.TEARFALLINGSPEED
    end
    if cache_flag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed - 1 + template.SHOTSPEED
    end
    if cache_flag == CacheFlag.CACHE_LUCK then
        player.Luck = player.Luck + template.LUCK
    end
    if cache_flag == CacheFlag.CACHE_TEARFLAG then
        player.TearFlags = player.TearFlags | template.TEARFLAG
    end
    if cache_flag == CacheFlag.CACHE_TEARCOLOR then
        player.TearColor = template.TEARCOLOR
    end
    if cache_flag == CacheFlag.CACHE_FLYING and template.FLYING then
        player.CanFly = true
    end
end
