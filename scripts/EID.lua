if EID then
    EID:addCollectible(Ark.Item.Info.Crown, "↑{{Damage}} 当血量不高于1时攻击力*1.5,如果玩家集齐了三件及以上的国王收藏品，则攻击力*2.5#（偶尔存在BUG使该效果失效）", "诸王的冠冕", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.New_Lance, "↑{{Tears}} 当血量不高于1时射速+3.27", "国王的新枪", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Armor, "获得后进入下一个房间时使红心降至1，减少的红心转化为魂心，且每进入一个房间后使红心-1、魂心+1，该效果不会使血量降低至0", "国王的铠甲", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Legacy, "飞舞道具，没用（其实是不知道怎么写增加充能）", "国王的延伸", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Beauty, "生成道具时会有奇妙效果", "美愿时代的留恋", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Hatred, "↓{{Damage}}攻击力*0.8（不会写敌人攻击力上升的效果，只能出此下策）", "死仇时代的恨意", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Golden_Chalice, "↑{{Tears}}每有1硬币，攻速+0.05", "金酒之杯", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Coin_Operated, "↑{{Tears}}每有1硬币，攻速+0.01", "投币玩具", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Chivalric_Commandments, "↑{{Tears}}每有1硬币，攻速+0.03", "骑士戒律·新编", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Screaming_Cherry, "↑{{Damage}}攻击力*1.15/*1.07", "尖叫樱桃", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Seaweed_Salad, "↑{{Tears}}攻速+0.5/+0.27", "凉拌海草", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Orange_Storm, "↑{{Damage}}攻击力*1.1/*1.05", "橙味风暴", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Coffee_Candy, "↑{{Tears}}攻速+0.61/0.33", "咖啡平原咖啡糖", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Antique_Coins, "硬币+20/16", "古旧钱币", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Flawless_Jadestone, "硬币+30/25", "无瑕宝玉", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Admin_Access_Card, "（硬币+3，)获得长子权", "游戏室管理员权限卡", 'zh_cn')
    EID:addCollectible(Ark.Item.Info.Petting_Ticket, "（魂心+1，）获得长子权", "Miss.Christine摸摸券", 'zh_cn')
    --[[不知为何加载下列代码后EID成英文了先BAN了，以后再做英语支持

    Somehow, after loading the following code, the EID became English. I BAN it for now and add English support later.
    If you are a EN player you can delete the 'zh_cn' EID coding and let these coding using

    EID:addCollectible(Crown,"↑{{Damage}} Damage+ when HP is no more than 1. If the player collects three or more king collectibles,damage+++. #(Occasionally there is a bug that makes this effect invalid.)","King's Crown","en_us")
    EID:addCollectible(New_Lance,"↑{{Tears}} Tears++ when HP is no more than 1.","King's New Lance","en_us")
    EID:addCollectible(Armor,"In each room entered, convert one red heart to one soul heart. This effect will not reduce the HP to 0.","King's Armor","en_us")
    EID:addCollectible(Legacy,"Useless item(actually don't know how to write the code to increase charge).","King's Legacy","en_us")
    EID:addCollectible(Beauty,"The code is too difficult to write. Currently, it only adds coins. # +10 coins. It may have wonderful effects in some rooms.","Nostalgia of Beauty","en_us")
    EID:addCollectible(Hatred,"↓{{Damage}} Attack decreases. (Don't know how to write the code to increase the enemy's attack, so this is the only option.)","Talons of Hatred","en_us")
    EID:addCollectible(Golden,"↑{{Tears}} For each coin,tears+++","Golden Chalice",en_us)
    EID:addCollectible(Coin_Operated,"↑{{Tears}} For each coin,tears+.","Coin-Operated Toy","en_us")
    EID:addCollectible(Chivalric_Commandments,"↑{{Tears}} For each coin,tears++.","Chivalric Commandments - New Edition","en_us")
    ]]
end
