MAILBOX_LOCATIONS = {
      "@Mailbox 01: Hairy/Mailbox 01: Hairy",
      "@Mailbox 02: Fosfor/Mailbox 02: Fosfor",
      "@Mailbox 03: Baldino/Mailbox 03: Baldino",
      "@Mailbox 04: Tweepers/Mailbox 04: Tweepers",
      "@Mailbox 05: Fleek/Mailbox 05: Fleek",
      "@Mailbox 06: Screech/Mailbox 06: Screech",
      "@Mailbox 07: Ape/Mailbox 07: Ape",
      "@Mailbox 08: Slug Gardener/Mailbox 08: Slug Gardener",
      "@Mailbox 09: Shed/Mailbox 09: Shed",
      "@Mailbox 10: Sal/Mailbox 10: Sal",
      "@Mailbox 11: Rolypoly/Mailbox 11: Rolypoly",
      "@Mailbox 12: Beach/Mailbox 12: Beach",
      "@Mailbox 13: Quinbe/Mailbox 13: Quinbe",
      "@Mailbox 14: Hideout/Mailbox 14: Hideout",
      "@Mailbox 15: Underbelly/Mailbox 15: Underbelly",
      "@Mailbox 16: Church/Mailbox 16: Church",
      "@Mailbox 17: Kambi/Mailbox 17: Kambi",
      "@Mailbox 18: Waterfall/Mailbox 18: Waterfall",
      "@Mailbox 19: Hub/Mailbox 19: Hub",
      "@Mailbox 20: Post Office/Mailbox 20: Post Office",
      "@Mailbox 21: Sandro/Mailbox 21: Sandro",
      "@Mailbox 22: Dipperloaf/Mailbox 22: Dipperloaf",
      "@Mailbox 23: Treek/Mailbox 23: Treek",
      "@Mailbox 24: Orestation/Mailbox 24: Orestation",
      "@Mailbox 25: Lighthouse/Mailbox 25: Lighthouse",
      "@Mailbox 26: Sin/Mailbox 26: Sin",
      "@Mailbox 27: Ithaqua/Mailbox 27: Ithaqua",
      "@Mailbox 28: Ojva/Mailbox 28: Ojva",
      "@Mailbox 29: Space Monks/Mailbox 29: Space Monks",
      "@Mailbox 30: Tower/Mailbox 30: Tower"
}

function updateMailboxCount()
    local boxesChecked = #MAILBOX_LOCATIONS
    for i,box in ipairs(MAILBOX_LOCATIONS) do
        local o = Tracker:FindObjectForCode(box)
        if o then
            boxesChecked = boxesChecked - o.AvailableChestCount
        end
    end
    mailbag = Tracker:FindObjectForCode("abilities_mailbag")
    mailbag:SetOverlay(boxesChecked)
end

ScriptHost:AddOnLocationSectionChangedHandler("Mailboxes", updateMailboxCount)
