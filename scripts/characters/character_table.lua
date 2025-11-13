-- 角色数据表
-- 存储所有角色 ID 和配置数据

-- 角色类型 ID
Ark.Character.Info.w_Type = Isaac.GetPlayerTypeByName("w")
Ark.Character.Info.wisadel_TYPE = Isaac.GetPlayerTypeByName("wisadel", true)

-- 服装 ID
Ark.Character.Info.W_hair_Costume = Isaac.GetCostumeIdByPath("gfx/characters/w_wis_hair.anm2")

-- 实体变体 ID
Ark.Character.Info.wis_tear = Isaac.GetEntityVariantByName("Shadow of Revenant bullt")

-- 运行时变量
Ark.Character.Variable.Num.w_has_pri = 0
Ark.Character.Variable.Num.wis_has_pri = 0

-- 角色属性模板
Ark.Character.Table.Template = {
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
