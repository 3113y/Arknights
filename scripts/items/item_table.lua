-- 道具数据表
-- 存储所有道具 ID 和相关配置数据

-- 道具 ID 定义
Ark.Item.Info.New_Lance = Isaac.GetItemIdByName("King's New Lance")
Ark.Item.Info.Legacy = Isaac.GetItemIdByName("King's Legacy")
Ark.Item.Info.Armor = Isaac.GetItemIdByName("King's Armor")
Ark.Item.Info.Crown = Isaac.GetItemIdByName("King's Crown")
Ark.Item.Info.Beauty = Isaac.GetItemIdByName("Nostalgia of Beauty")
Ark.Item.Info.Hatred = Isaac.GetItemIdByName("Talons of Hatred")
Ark.Item.Info.Golden_Chalice = Isaac.GetItemIdByName("Golden Chalice")
Ark.Item.Info.Coin_Operated = Isaac.GetItemIdByName("Coin-Operated Toy")
Ark.Item.Info.Chivalric_Commandments = Isaac.GetItemIdByName("Chivalric Commandments - New Edition")
Ark.Item.Info.Seaweed_Salad = Isaac.GetItemIdByName("Seaweed Salad")
Ark.Item.Info.Orange_Storm = Isaac.GetItemIdByName("Orange Storm")
Ark.Item.Info.Coffee_Candy = Isaac.GetItemIdByName("Coffee Plains Coffee Candy")
Ark.Item.Info.Screaming_Cherry = Isaac.GetItemIdByName("Screaming Cherry")
Ark.Item.Info.Antique_Coins = Isaac.GetItemIdByName("Antique Coins")
Ark.Item.Info.Flawless_Jadestone = Isaac.GetItemIdByName("Flawless Jadestone")
Ark.Item.Info.Admin_Access_Card = Isaac.GetItemIdByName("Game Room Admin Access Card")
Ark.Item.Info.Petting_Ticket = Isaac.GetItemIdByName("Ms. Christine Petting Ticket")
Ark.Item.Info.Shadow_Revenant = Isaac.GetItemIdByName("Shadow of Revenant")
Ark.Item.Info.D12 = Isaac.GetItemIdByName("D12")

-- 实体变体 ID
Ark.Item.Info.Shadow_Revenant_Variant = Isaac.GetEntityVariantByName("Shadow of Revenant")
Ark.Item.Info.Shadow_Revenant_Bullt_Variant = Isaac.GetEntityVariantByName("Shadow of Revenant bullt")

-- 道具配置
Ark.Item.Info.Shadow_Revenant_Config = Isaac.GetItemConfig():GetCollectible(Ark.Item.Info.Shadow_Revenant)

-- 运行时变量
Ark.Item.Variable.Num.mon_1 = 0
Ark.Item.Variable.Num.mon_2 = 0
Ark.Item.Variable.Num.tainted_lazarus = 0

-- 难度系数配置表
Ark.Item.Table.difficulty_coefficients = {
    -- 金杯：每金币增加的射速
    golden_chalice = {
        [Difficulty.DIFFICULTY_NORMAL] = 0.05,
        [Difficulty.DIFFICULTY_HARD] = 0.05,
        [Difficulty.DIFFICULTY_GREED] = 0.05,
        [Difficulty.DIFFICULTY_GREEDIER] = 0.05
    },
    -- 投币玩具：每金币增加的射速
    coin_operated = {
        [Difficulty.DIFFICULTY_NORMAL] = 0.01,
        [Difficulty.DIFFICULTY_HARD] = 0.01,
        [Difficulty.DIFFICULTY_GREED] = 0.01,
        [Difficulty.DIFFICULTY_GREEDIER] = 0.01
    },
    -- 骑士戒律：每金币增加的射速
    chivalric_commandments = {
        [Difficulty.DIFFICULTY_NORMAL] = 0.03,
        [Difficulty.DIFFICULTY_HARD] = 0.03,
        [Difficulty.DIFFICULTY_GREED] = 0.03,
        [Difficulty.DIFFICULTY_GREEDIER] = 0.03
    },
    -- 凉拌海草：射速加成
    seaweed_salad = {
        [Difficulty.DIFFICULTY_NORMAL] = 0.25,
        [Difficulty.DIFFICULTY_HARD] = 0.5,
        [Difficulty.DIFFICULTY_GREED] = 0.25,
        [Difficulty.DIFFICULTY_GREEDIER] = 0.5
    },
    -- 橘味风暴：伤害倍率
    orange_storm = {
        [Difficulty.DIFFICULTY_NORMAL] = 1.05,
        [Difficulty.DIFFICULTY_HARD] = 1.1,
        [Difficulty.DIFFICULTY_GREED] = 1.05,
        [Difficulty.DIFFICULTY_GREEDIER] = 1.1
    },
    -- 咖啡糖：射速加成
    coffee_candy = {
        [Difficulty.DIFFICULTY_NORMAL] = 0.3,
        [Difficulty.DIFFICULTY_HARD] = 0.6,
        [Difficulty.DIFFICULTY_GREED] = 0.3,
        [Difficulty.DIFFICULTY_GREEDIER] = 0.6
    },
    -- 尖叫樱桃：伤害倍率
    screaming_cherry = {
        [Difficulty.DIFFICULTY_NORMAL] = 1.07,
        [Difficulty.DIFFICULTY_HARD] = 1.15,
        [Difficulty.DIFFICULTY_GREED] = 1.07,
        [Difficulty.DIFFICULTY_GREEDIER] = 1.15
    },
    -- 古旧钱币：金币数量
    antique_coins = {
        [Difficulty.DIFFICULTY_NORMAL] = 16,
        [Difficulty.DIFFICULTY_HARD] = 20,
        [Difficulty.DIFFICULTY_GREED] = 16,
        [Difficulty.DIFFICULTY_GREEDIER] = 20
    },
    -- 无瑕宝玉：金币数量
    flawless_jadestone = {
        [Difficulty.DIFFICULTY_NORMAL] = 25,
        [Difficulty.DIFFICULTY_HARD] = 30,
        [Difficulty.DIFFICULTY_GREED] = 25,
        [Difficulty.DIFFICULTY_GREEDIER] = 30
    },
    -- 管理员卡：金币数量
    admin_access_card_coins = {
        [Difficulty.DIFFICULTY_NORMAL] = 0,
        [Difficulty.DIFFICULTY_HARD] = 3,
        [Difficulty.DIFFICULTY_GREED] = 0,
        [Difficulty.DIFFICULTY_GREEDIER] = 3
    },
    -- 摸摸券：魂心数量
    petting_ticket_souls = {
        [Difficulty.DIFFICULTY_NORMAL] = 0,
        [Difficulty.DIFFICULTY_HARD] = 2,
        [Difficulty.DIFFICULTY_GREED] = 0,
        [Difficulty.DIFFICULTY_GREEDIER] = 2
    }
}

-- 美愿变身套装标签
Ark.Item.Table.transformation_tags = {
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
