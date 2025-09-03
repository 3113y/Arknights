--道具回调
Ark_mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Ark_mod.Ar_Beginning)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.New_Lance_Effect)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Crown_Effect)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Coins_Tears)
Ark_mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Ark_mod.ForceEvaluateCache)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Seaweed_Salad)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Orange_Storm)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Coffee_Candy)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Screaming_Cherry)
Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Antique_Coins)
Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Flawless_Jadestone)
Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Admin_Access_Card)
Ark_mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Ark_mod.Petting_Ticket)
Ark_mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, Ark_mod.Beauty_Effect)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.Evaluate_Shadow_Revenant_Cache, CacheFlag.CACHE_FAMILIARS)
Ark_mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Ark_mod.HandleInit_Shadow_Revenant, Shadow_Revenant_VARIANT)
Ark_mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Ark_mod.HandleUpdate_Shadow_Revenant, Shadow_Revenant_VARIANT)

Ark_mod:AddCallback(ModCallbacks.MC_USE_ITEM, Ark_mod.D12)
--人物回调
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.w_onCache)
Ark_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Ark_mod.wis_onCache)

--mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.OnRemove, EntityType.ENTITY_TEAR)
--诅咒回调