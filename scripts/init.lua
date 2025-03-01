local variant = Tracker.ActiveVariantUID
local items_only = variant:find("onlyitems")
ENABLE_DEBUG_LOG = false

--scripts
ScriptHost:LoadScript("scripts/logic.lua")
if PopVersion > "0.26.2" then
    ScriptHost:LoadScript("scripts/mailbag.lua")
end
-- custom stuff goes here

--ScriptHost:LoadScript("scripts/logic.lua")
--ScriptHost:LoadScript("scripts/watches.lua")
--items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings.json")
if not items_only then
    --maps
    Tracker:AddMaps("maps/maps.json")
    --locations
    Tracker:AddLocations("locations/locations.json")
    --additional locations
    Tracker:AddLocations("locations/fixed.json")
end
--layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")

-- autotracking
if PopVersion then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
