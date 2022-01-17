
local bonkprefab
for k, v in pairs(AfflictionPrefab.ListArray) do
    if v.name == "Blunt force trauma" then
       bonkprefab = v
       break
    end
end

Hook.Add("changeFallDamage", "testFallDamage", function (amount, character, impactpos, velocity)
    if character.AnimController ~= nil then
        for _, limb in pairs(character.AnimController.Limbs) do
            local sqvel = (velocity.Length()) * (velocity.Length())
            --character.CharacterHealth.ApplyAffliction(limb, bonkprefab.Instantiate(dmg))
			
            local checkdist = 30 --Ragdoll to wall type of fall
            local multiplier = 0.5
			
            if sqvel > 60 then -- 1 floor drop
                checkdist = 50
                multiplier = 0.7
            end
			
            if sqvel > 120 then -- 2 floor drop = very fucked
                checkdist = 100
                multiplier = 1
            end
			
            if sqvel >= 150 then -- 3 floor drop = ded
                checkdist = 300
                multiplier = 2
            end
			
            local dmg = (sqvel * 3)/(limb.WorldPosition - impactpos).Length() * multiplier
            if (limb.WorldPosition - impactpos).Length() < checkdist then
                character.CharacterHealth.ApplyAffliction(limb, bonkprefab.Instantiate(dmg))
                --Game.SendMessage(sqvel, ChatMessageType.Server) --For debugging purposes
                --Game.SendMessage(dmg, ChatMessageType.Server) --For debugging purposes
            end
        end
    end
    return 0
end)

