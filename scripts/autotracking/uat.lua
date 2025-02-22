-- UAT example pack by black_sliver
-- autotracking.lua

-- For this demo we named the item codes and location section identical to the game variables.
-- Note that codes and variable names are case sensitive.
--
-- The return value of :ReadVariable can be anything, so we check the type and
-- * for toggles accept nil, false, integers <= 0 and empty strings as `false`
-- * for consumables everything that is not a number will be 0
-- * for progressive toggles we expect json [bool,number] or [number,number]
-- * for chests this is left as an exercise for the reader
-- Alternatively try-catch (pcall) can be used to handle unexpected values.

function updateToggles(store, vars)
    print("updateToggles")
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode(var)
        local val = store:ReadVariable(var)
        if type(val) == "number" then; o.Active = val > 0
        elseif type(val) == "string" then; o.Active = val ~= ""
        else; o.Active = not(not val)
        end
        print(var .. " = " .. tostring(val) .. " -> " .. tostring(o.Active))
    end
end

function updateConsumables(store, vars)
    print("updateConsumables")
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode(var)
        local val = store:ReadVariable(var)
        if type(val) == "number" then; o.AcquiredCount = val
        else; o.AcquiredCount = 0
        end
        print(var .. " = " .. tostring(val) .. " -> " .. o.AcquiredCount)
    end
end

function updateProgressives(store, vars)
    print("updateProgressives")
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode(var)
        local val = store:ReadVariable(var)
        if type(val) == "number" then; o.CurrentStage = val
        else; o.CurrentStage = 0
        end
        print(var .. " = " .. tostring(val) .. " -> " .. o.CurrentStage)
    end
end

-- Table of variables which substitute for one another in a progressive and their stages
alternates = {
    ["abilities_slug_vacuum"] = {"abilities_slug_upgrade", 1},
    ["abilities_slug_upgrade"] = {"abilities_slug_vacuum", 2},
    ["sootling_leash"] = {"abilities_hook", 1},
    ["abilities_hook"] = {"sootling_leash", 2},
    ["abilities_dive"] = {"abilities_dive_speed", 1},
    ["abilities_dive_speed"] = {"abilities_dive", 2},
    ["powerups_skvader_1"] = {"powerups_skvader_2", 1},
    ["powerups_skvader_2"] = {"powerups_skvader_1", 2},
}

function updateUpgradeProgressives(store, vars)
    print("updateUpgradeProgressives")
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode(var)
        local val2
        local var2
        if alternates[var] then
            var2 = alternates[var][1]
            val2 = store:ReadVariable(var2)
        end
        local val = store:ReadVariable(var)
        if (type(val) == "number" and val>0) then; o.CurrentStage = alternates[var][2]
        else; o.CurrentStage = 0
        end
        if (type(val2) == "number" and val2>0) then
            if (alternates[var2][2]>o.CurrentStage) then; o.CurrentStage = alternates[var2][2]; end
        end
        print(var .. " = " .. tostring(val) .. " -> " .. o.CurrentStage)
    end
end

function updateProgressiveToggles(store, vars)
    print("updateProgressiveToggles")
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode(var)
        local val = store:ReadVariable(var)
        if type(val) == "table" and type(val[2]) == "number" then
            if type(val[1]) == "number" then; o.Active = val[1]>0
            else; o.Active = not(not val[1])
            end
            o.CurrentStage = val[2]
        else
            o.Active = false
        end
        print(var .. " = " .. tostring(val) .. " -> " .. tostring(o.Active) .. "," .. o.CurrentStage)
    end
end

function updateLocations(store, vars)
    print("updateLocations")
    -- Sections are named NAME/NAME for source compatibility
    for _, var in ipairs(vars) do
        local o = Tracker:FindObjectForCode("@"..var) -- grab section
        local val = store:ReadVariable(var)
        o.AvailableChestCount = o.ChestCount - val -- in this case val = that many chests are looted
        print(var .. " = " .. tostring(val) .. " -> " .. tostring(o.AvailableChestCount))
    end
end

ScriptHost:AddVariableWatch("toggles", {
    "mushroom_2",
    "mushroom_3",
    "postal_badge",
    "abilities_partyhorn",
    "toolbox",
    "abilities_mailbag",
    "guano",
    "bucket_empty",
    "seed_pod",
    "spring_key",
    "skins_skin_1",
    "skins_skin_2",
    "skins_skin_5",
    "skins_skin_3",
    "skins_skin_4",
    "spores_1",
    "spores_2",
    "spores_3",
    "spores_4",
    "spores_5",
    "bluekey",
    "greenkey",
    "nim_key",
    "tracker_springs",
    "tracker_caves",
    "tracker_peak",
    "tracker_scarabs",
    "treasure_map",
    "abilities_speed",
    "kazoos"
}, updateToggles)

ScriptHost:AddVariableWatch("consumables", {"wickerling"}, updateConsumables)

ScriptHost:AddVariableWatch("progressive", {
    "idol",
    "nugget",
    "tadpole",
    "wallet",
    "traitor_spirit",
}, updateProgressives)

ScriptHost:AddVariableWatch("upgradeProgressive", {
    "abilities_slug_vacuum",
    "abilities_slug_upgrade",
    "sootling_leash",
    "abilities_hook",
    "abilities_dive",
    "abilities_dive_speed",
    "powerups_skvader_1",
    "powerups_skvader_2",
}, updateUpgradeProgressives)

ScriptHost:AddVariableWatch("locations", {
    "Juicy Cove Mushroom/Juicy Cove Mushroom",
    "Poison Toadstool/Poison Toadstool",
    "Toolbox/Toolbox",
    "Guano/Guano",
    "Seed Pod/Seed Pod",
    "Underwater Puzzle/Underwater Puzzle",
    "Tower's Peak Crystal/Tower's Peak Crystal",
    "Post Office Attic/Post Office Attic",
    "Key: Blue/Key: Blue",
    "Key: Green/Key: Green",
    "Sootling 1/Sootling 1",
    "Sootling 2/Sootling 2",
    "Sootling 3/Sootling 3",
    "Sootling 4/Sootling 4",
    "Sootling 5/Sootling 5",
    "Sootling 6/Sootling 6",
    "Tadpole 1/Tadpole 1",
    "Tadpole 2/Tadpole 2",
    "Tadpole 3/Tadpole 3",
    "Tadpole 4/Tadpole 4",
    "Tadpole 5/Tadpole 5",
    "Tadpole 6/Tadpole 6",
    "Tadpole 7/Tadpole 7",
    "Tadpole 8/Tadpole 8",
    "Mulch Pit: Village/Mulch Pit: Village",
    "Mulch Pit: Ape/Mulch Pit: Ape",
    "Mulch Pit: Beach/Mulch Pit: Beach",
    "Mulch Pit: Ivory/Mulch Pit: Ivory",
    "Statue Piece: Waterfall/Statue Piece: Waterfall",
    "Statue Piece: Underdark/Statue Piece: Underdark",
    "Statue Piece: Ivory/Statue Piece: Ivory",
    "Statue Piece: Obt. Isles/Statue Piece: Obt. Isles",
    "Nugget 1/Nugget 1",
    "Nugget 2/Nugget 2",
    "Nugget 3/Nugget 3",
    "Nugget 4/Nugget 4",
    "Chest: Noisemaker/Chest: Noisemaker",
    "Chest: Tweepers/Chest: Tweepers",
    "Chest: Tower/Chest: Tower",
    "Chest: Shed/Chest: Shed",
    "Chest: Crystal Skull/Chest: Crystal Skull",
    "Chest: Beach/Chest: Beach",
    "Chest: Church/Chest: Church",
    "Chest: Leash/Chest: Leash",
    "Chest: Treek/Chest: Treek",
    "Chest: Town Skip/Chest: Town Skip",
    "Chest: Lava/Chest: Lava",
    "Chest: Waterfall/Chest: Waterfall",
    "Chest: Fosfor Cave Left/Chest: Fosfor Cave Left",
    "Chest: Fleek/Chest: Fleek",
    "Chest: Screech/Chest: Screech",
    "Chest: Willo/Chest: Willo",
    "Mailbox 01: Hairy/Mailbox 01: Hairy",
    "Mailbox 02: Fosfor/Mailbox 02: Fosfor",
    "Mailbox 03: Baldino/Mailbox 03: Baldino",
    "Mailbox 04: Tweepers/Mailbox 04: Tweepers",
    "Mailbox 05: Fleek/Mailbox 05: Fleek",
    "Mailbox 06: Screech/Mailbox 06: Screech",
    "Mailbox 07: Ape/Mailbox 07: Ape",
    "Mailbox 08: Slug Gardener/Mailbox 08: Slug Gardener",
    "Mailbox 09: Shed/Mailbox 09: Shed",
    "Mailbox 10: Sal/Mailbox 10: Sal",
    "Mailbox 11: Rolypoly/Mailbox 11: Rolypoly",
    "Mailbox 12: Beach/Mailbox 12: Beach",
    "Mailbox 13: Quinbe/Mailbox 13: Quinbe",
    "Mailbox 14: Hideout/Mailbox 14: Hideout",
    "Mailbox 15: Underbelly/Mailbox 15: Underbelly",
    "Mailbox 16: Church/Mailbox 16: Church",
    "Mailbox 17: Kambi/Mailbox 17: Kambi",
    "Mailbox 18: Waterfall/Mailbox 18: Waterfall",
    "Mailbox 19: Hub/Mailbox 19: Hub",
    "Mailbox 20: Post Office/Mailbox 20: Post Office",
    "Mailbox 21: Sandro/Mailbox 21: Sandro",
    "Mailbox 22: Dipperloaf/Mailbox 22: Dipperloaf",
    "Mailbox 23: Treek/Mailbox 23: Treek",
    "Mailbox 24: Orestation/Mailbox 24: Orestation",
    "Mailbox 25: Lighthouse/Mailbox 25: Lighthouse",
    "Mailbox 26: Sin/Mailbox 26: Sin",
    "Mailbox 27: Ithaqua/Mailbox 27: Ithaqua",
    "Mailbox 28: Ojva/Mailbox 28: Ojva",
    "Mailbox 29: Space Monks/Mailbox 29: Space Monks",
    "Mailbox 30: Tower/Mailbox 30: Tower",
    "Fruit 31: Banana Chest/Fruit 31: Banana Chest",
    "Fruit 32: Green Chest/Fruit 32: Green Chest",
    "Fruit 33: Hook Chest/Fruit 33: Hook Chest",
    "Fruit 34: Underwater Chest/Fruit 34: Underwater Chest",
    "Scarab 35: Mushrooms Left/Scarab 35: Mushrooms Left",
    "Scarab 36: Mushrooms Right/Scarab 36: Mushrooms Right",
    "Scarab 37: Sootling House Upper/Scarab 37: Sootling House Upper",
    "Scarab 38: Sootling House Lower/Scarab 38: Sootling House Lower",
    "Scarab 39: Tower Right/Scarab 39: Tower Right",
    "Scarab 40: Tower Left/Scarab 40: Tower Left",
    "Scarab 41: Tower Upper/Scarab 41: Tower Upper",
    "Scarab 42: Juicery Lower/Scarab 42: Juicery Lower",
    "Scarab 43: Juicery Upper/Scarab 43: Juicery Upper",
    "Scarab 44: Orestation Right/Scarab 44: Orestation Right",
    "Scarab 45: Orestation Left/Scarab 45: Orestation Left",
    "Scarab 46: Lighthouse I Right/Scarab 46: Lighthouse I Right",
    "Scarab 47: Lighthouse I Left/Scarab 47: Lighthouse I Left",
    "Scarab 48: Lighthouse II/Scarab 48: Lighthouse II",
    "Scarab 49: Town Skip/Scarab 49: Town Skip",
    "Scarab 50: Bat/Scarab 50: Bat",
    "Scarab 51: Spider Cave I/Scarab 51: Spider Cave I",
    "Scarab 52: Spider Cave II/Scarab 52: Spider Cave II",
    "Scarab 53: Underbelly II Right/Scarab 53: Underbelly II Right",
    "Scarab 54: Underbelly II Left/Scarab 54: Underbelly II Left",
    "Scarab 55: Underbelly I Right/Scarab 55: Underbelly I Right",
    "Scarab 56: Underbelly I Left/Scarab 56: Underbelly I Left",
    "Scarab 57: Underbelly I Mid/Scarab 57: Underbelly I Mid",
    "Scarab 58: Willo Right/Scarab 58: Willo Right",
    "Scarab 59: Willo Mid/Scarab 59: Willo Mid",
    "Scarab 60: Willo Left/Scarab 60: Willo Left",
    "Scarab 61: Crystal Skull Upper/Scarab 61: Crystal Skull Upper",
    "Scarab 62: Crystal Skull Left/Scarab 62: Crystal Skull Left",
    "Scarab 63: Crystal Skull Right/Scarab 63: Crystal Skull Right",
    "Scarab 64: Trial I Right/Scarab 64: Trial I Right",
    "Scarab 65: Trial I Left/Scarab 65: Trial I Left",
    "Scarab 66: Trial II Right/Scarab 66: Trial II Right",
    "Scarab 67: Trial II Left/Scarab 67: Trial II Left",
    "Scarab 68: Trial III Right/Scarab 68: Trial III Right",
    "Scarab 69: Trial III Left/Scarab 69: Trial III Left",
    "Scarab 70: Door Friend I/Scarab 70: Door Friend I",
    "Scarab 71: Meadow I Left/Scarab 71: Meadow I Left",
    "Scarab 72: Meadow I Right/Scarab 72: Meadow I Right",
    "Scarab 73: Meadow II Upper/Scarab 73: Meadow II Upper",
    "Scarab 74: Meadow II Lower/Scarab 74: Meadow II Lower",
    "Scarab 75: Meadow IV/Scarab 75: Meadow IV",
    "Scarab 76: Meadow V/Scarab 76: Meadow V",
    "Fruit 77: Waterfall Left/Fruit 77: Waterfall Left",
    "Fruit 78: Underbelly/Fruit 78: Underbelly",
    "Fruit 79: Waterfall Right/Fruit 79: Waterfall Right",
    "Fruit 80: Meadows Slug Rock/Fruit 80: Meadows Slug Rock",
    "Fruit 81: Marrow Jump/Fruit 81: Marrow Jump",
    "Fruit 82: Screech Door Bones/Fruit 82: Screech Door Bones",
    "Fruit 83: Sootling Cave Water/Fruit 83: Sootling Cave Water",
    "Fruit 84: Sootling Cave Right/Fruit 84: Sootling Cave Right",
    "Fruit 85: Sootling Cave Left/Fruit 85: Sootling Cave Left",
    "Fruit 86: Sin/Fruit 86: Sin",
    "Fruit 87: Crystal Lake/Fruit 87: Crystal Lake",
    "Fruit 88: Spider Cave/Fruit 88: Spider Cave",
    "Fruit 89: Treasure Room/Fruit 89: Treasure Room",
    "Fruit 90: Ocean Heart/Fruit 90: Ocean Heart",
    "Lemon/NPC: Lemon",
    "Lemon/NPC: Lemon, All Packages",
    "Rinri/NPC: Rinri, Quest",
    "Rinri/NPC: Rinri, Reward",
    "NPC: Tweepers/NPC: Tweepers",
    "NPC: Skeeper/NPC: Skeeper",
    "NPC: Cleepers/NPC: Cleepers",
    "NPC: Dive Fish/NPC: Dive Fish",
    "NPC: Myrtle/NPC: Myrtle",
    "NPC: Treek/NPC: Treek",
    "NPC: Quinbe/NPC: Quinbe",
    "NPC: Sumoe/NPC: Sumoe",
    "NPC: Splank/NPC: Splank",
    "NPC: Liquorice/NPC: Liquorice",
    "NPC: Posterodactyl/NPC: Posterodactyl",
    "NPC: Kickback/NPC: Kickback",
    "NPC: Nim/NPC: Nim",
    "NPC: Dipperloaf/NPC: Dipperloaf",
    "NPC: Jamja/NPC: Jamja",
    "NPC: Jojo/NPC: Jojo",
    "NPC: Fleek/NPC: Fleek",
    "NPC: Dusk/NPC: Dusk",
    "Wl. 01: Beach Dive 1/Wl. 01: Beach Dive 1",
    "Wl. 02: Beach Dive 2/Wl. 02: Beach Dive 2",
    "Wl. 03: Hairy/Wl. 03: Hairy",
    "Wl. 04: Intro 1/Wl. 04: Intro 1",
    "Wl. 05: Intro 2/Wl. 05: Intro 2",
    "Wl. 06: Fosfor Tunnel/Wl. 06: Fosfor Tunnel",
    "Wl. 07: Fosfor Cave/Wl. 07: Fosfor Cave",
    "Wl. 08: Fosfor Door/Wl. 08: Fosfor Door",
    "Wl. 09: Above Fosfor/Wl. 09: Above Fosfor",
    "Wl. 10: Gorila Woods Beeline/Wl. 10: Gorila Woods Beeline",
    "Wl. 11: Tower Table/Wl. 11: Tower Table",
    "Wl. 12: Ape Chest/Wl. 12: Ape Chest",
    "Wl. 13: Ape Hook/Wl. 13: Ape Hook",
    "Wl. 14: Ape Entry/Wl. 14: Ape Entry",
    "Wl. 15: Ape Right/Wl. 15: Ape Right",
    "Wl. 16: Slug Gardener Spot 2/Wl. 16: Slug Gardener Spot 2",
    "Wl. 17: Slug Gardener Spot 1/Wl. 17: Slug Gardener Spot 1",
    "Wl. 18: Meadow Slug Jump/Wl. 18: Meadow Slug Jump",
    "Wl. 19: Waterfall Bottom/Wl. 19: Waterfall Bottom",
    "Wl. 20: Shed/Wl. 20: Shed",
    "Wl. 21: Waterfall Ledge/Wl. 21: Waterfall Ledge",
    "Wl. 22: Waterfall Dive Through/Wl. 22: Waterfall Dive Through",
    "Wl. 23: Tower Mid/Wl. 23: Tower Mid",
    "Wl. 24: Tower Top/Wl. 24: Tower Top",
    "Wl. 25: Lonka/Wl. 25: Lonka",
    "Wl. 26: Post Office Junk/Wl. 26: Post Office Junk",
    "Lemon/Wl. 27: All Mailboxes",
    "Wl. 28: Above Rinri/Wl. 28: Above Rinri",
    "Wl. 29: Instrument Cave/Wl. 29: Instrument Cave",
    "Wl. 30: Treek/Wl. 30: Treek",
    "Wl. 31: Dipperloaf/Wl. 31: Dipperloaf",
    "Wl. 32: Juicery Upper/Wl. 32: Juicery Upper",
    "Wl. 33: Juicery Left/Wl. 33: Juicery Left",
    "Wl. 34: Fleek/Wl. 34: Fleek",
    "Wl. 35: Sin Totem/Wl. 35: Sin Totem",
    "Wl. 36: Obt. Puzzle/Wl. 36: Obt. Puzzle",
    "Wl. 37: End Boss Fight/Wl. 37: End Boss Fight",
    "Wl. 38: Orestation Bottom/Wl. 38: Orestation Bottom",
    "Wl. 39: God Misfire/Wl. 39: God Misfire",
    "Wl. 40: Leap of Faith/Wl. 40: Leap of Faith",
    "Wl. 41: Squirrowl/Wl. 41: Squirrowl",
    "Wl. 42: Orestation Hook/Wl. 42: Orestation Hook",
    "Wl. 43: Lighthouse Ledge/Wl. 43: Lighthouse Ledge",
    "Wl. 44: Lighthouse Slug Rock/Wl. 44: Lighthouse Slug Rock",
    "Wl. 45: Lighthouse Leap/Wl. 45: Lighthouse Leap",
    "Wl. 46: Sootling Cave/Wl. 46: Sootling Cave",
    "Wl. 47: Kickback Hiding Cave/Wl. 47: Kickback Hiding Cave",
    "Wl. 48: Telescope Skip Lower/Wl. 48: Telescope Skip Lower",
    "Wl. 49: Telescope Skip Upper/Wl. 49: Telescope Skip Upper",
    "Wl. 50: Ivory Hook Lower/Wl. 50: Ivory Hook Lower",
    "Wl. 51: Sumoe/Wl. 51: Sumoe",
    "Wl. 52: Ivory Hook Upper/Wl. 52: Ivory Hook Upper",
    "Wl. 53: Jamja Ledge/Wl. 53: Jamja Ledge",
    "Wl. 54: Spider Cave Entry/Wl. 54: Spider Cave Entry",
    "Wl. 55: Spider Cave Slug Rock/Wl. 55: Spider Cave Slug Rock",
    "Wl. 56: Above Willo at Waterfall/Wl. 56: Above Willo at Waterfall",
    "Wl. 57: Church Chest/Wl. 57: Church Chest",
    "Wl. 58: Church Ceiling/Wl. 58: Church Ceiling",
    "Wl. 59: Dive Cave Entry/Wl. 59: Dive Cave Entry",
    "Wl. 60: Dive Cave Chest/Wl. 60: Dive Cave Chest",
    "Wl. 61: Underwater at Hook Chest/Wl. 61: Underwater at Hook Chest",
    "Wl. 62: Underbelly I Left/Wl. 62: Underbelly I Left",
    "Wl. 63: Underbelly I Upper/Wl. 63: Underbelly I Upper",
    "Wl. 64: Underbelly I Right/Wl. 64: Underbelly I Right",
    "Wl. 65: Underbelly II Hidden/Wl. 65: Underbelly II Hidden",
    "Wl. 66: Hideout Drop 2/Wl. 66: Hideout Drop 2",
    "Wl. 67: Sush/Wl. 67: Sush",
    "Wl. 68: Hideout Ledge/Wl. 68: Hideout Ledge",
    "Wl. 69: Hideout Slug Rock/Wl. 69: Hideout Slug Rock",
    "Wl. 70: Hideout Drop 1/Wl. 70: Hideout Drop 1",
    "Wl. 71: Crystal Skull Upper/Wl. 71: Crystal Skull Upper",
    "Wl. 72: Crystal Skull Slug Rock/Wl. 72: Crystal Skull Slug Rock",
    "Wl. 73: Crystal Skull Chest/Wl. 73: Crystal Skull Chest",
    "Wl. 74: Above Rolypoly/Wl. 74: Above Rolypoly",
    "Wl. 75: Crystal Deep Beel. Ledge/Wl. 75: Crystal Deep Beel. Ledge",
    "Wl. 76: Underdark Water Puzzle/Wl. 76: Underdark Water Puzzle",
    "Wl. 77: Blue Chest/Wl. 77: Blue Chest",
    "Wl. 78: Pitch/Wl. 78: Pitch",
    "Wl. 79: Screech Door Hook/Wl. 79: Screech Door Hook",
    "Wl. 80: Behind Screech/Wl. 80: Behind Screech",
    "Traitor Spirit 1/Traitor Spirit 1",
    "Traitor Spirit 2/Traitor Spirit 2",
    "Traitor Spirit 3/Traitor Spirit 3",
    "Traitor Spirit 4/Traitor Spirit 4"
}, updateLocations)
