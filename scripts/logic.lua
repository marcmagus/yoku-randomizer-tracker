function hasNimKey()
    return Tracker:ProviderCountForCode("nim_key") > 0
end

function hasPartyHorn()
    return Tracker:ProviderCountForCode("abilities_partyhorn") > 0
end

function hasLeash()
    return Tracker:ProviderCountForCode("sootling_leash") > 0
end

function hasHook()
    return Tracker:ProviderCountForCode("abilities_hook") > 0
end

function hasToolbox()
    return Tracker:ProviderCountForCode("toolbox") > 0
end

function hasSlugVacuum()
    return Tracker:ProviderCountForCode("abilities_slug_vacuum") > 0
end

function hasPostalBadge()
    return Tracker:ProviderCountForCode("postal_badge") > 0
end

function hasMushroom2()
    return Tracker:ProviderCountForCode("mushroom_2") > 0
end

function hasMushroom3()
    return Tracker:ProviderCountForCode("mushroom_3") > 0
end

function canLeaveIntro()
    return (hasPostalBadge() and (hasMushroom2() or hasMushroom3()))
end

function canGetHook()
    return (hasHook() or (canLeaveIntro() and hasLeash() and hasToolbox() and hasSlugVacuum() and hasPartyHorn()))
end

function inGoMode()
    -- TODO: update for very hard
    return (hasNimKey() and hasPartyHorn() and canGetHook() and canLeaveIntro())
end

function checkGoMode()
    local goLight = Tracker:FindObjectForCode("go_light")

    -- print(string.format("Testing Go Mode: %s",inGoMode()))

    if inGoMode() then
        goLight.Active = true
    else
        goLight.Active = false
    end

    return 0
end

function apScouting(v)
    if not v then
        v = 1
    end
    if Tracker:ProviderCountForCode("ap_scouting") == tonumber(v) then
        return 1
    else
        return 0
    end
end
