
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
            local checkdist = 30
            local multiplier = 1
            if sqvel > 120 then
                checkdist = 100
                multiplier = 0.2
            end
            if sqvel >= 150 then
                checkdist = 300
                multiplier = 5
            end
            local dmg = (sqvel * 3)/(limb.WorldPosition - impactpos).Length() * multiplier
            if (limb.WorldPosition - impactpos).Length() < checkdist then
               character.CharacterHealth.ApplyAffliction(limb, bonkprefab.Instantiate(dmg))
            end
        end
    end
    return 0
end)

