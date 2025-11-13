-- 苦难诅咒功能

-- 诅咒计算
---@param curse_flags integer
---@return integer
function Ark_MOD:Curse_Calculate(curse_flags)
    if math.random(100) < 10 then
        curse_flags = Ark.Curse.Info.Sufferings
    end
    return curse_flags
end

-- 苦难诅咒效果
function Ark_MOD:Curse_Sufferings()
    local level = Game():GetLevel()
    local curse = level:GetCurses()
    if curse == Ark.Curse.Info.Sufferings then
        for i = 0, Game():GetNumPlayers() - 1 do
            local player = Game():GetPlayer(i)
            local health = player:GetHearts() + player:GetBlackHearts() + player:GetSoulHearts() + player:GetGoldenHearts() + player:GetBoneHearts()
            
            if player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B or health <= 2 then
                return
            else
                local decl = math.floor(health * 0.6)
                player:TakeDamage(decl, DamageFlag.DAMAGE_INVINCIBLE, EntityRef(player), 60)
            end
        end
    end
end

-- 注意：需要在合适的回调中调用这些函数
