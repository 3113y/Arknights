include("callbacks")
Sufferings = Isaac.GetCurseIdByName("Sufferings")
Commerce =  Isaac.GetCurseIdByName("Commerce")
Oddities = Isaac.GetCurseIdByName("Oddities")
function Ark_mod:curse_caculate(CurseFlags)
    if math.random(100) < 10 then
        CurseFlags = Sufferings
    end
    return CurseFlags
end

function Sufferings()
    local level = Game():GetLevel()
    local curse = level:GetCurses()
    if curse == Sufferings then
        for i = 0, Game():GetNumPlayers() - 1 do
            local player = Game():GetPlayer(i)
            local health = player:GetHearts()+player:GetBlackHearts()+player:GetSoulHearts()+player:GetGoldenHearts()+player:GetBoneHearts()
            if player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B or health <= 2 then
                return
            else
                local decl = math.floor(health*0.6)
                player:TakeDamage(decl, DamageFlag.DAMAGE_INVINCIBLE,EntityRef(player), 60)
            end
        end
    end
end