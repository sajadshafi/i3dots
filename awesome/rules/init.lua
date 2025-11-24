local ruled = require("ruled")
local awful = require("awful")
require("rules.taglist_rules")

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })

    -- Floating clients.
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "Sxiv",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    })

    local tag_icons = { "", "", "󰈹", "", "󰭹", "󱓷", "", "", "" }

    -- Tag 1: Terminals
    ruled.client.append_rule({
        rule_any = {
            class = { "kitty", "Alacritty", "XTerm", "Gnome-terminal" }
        },
        properties = { tag = tag_icons[1] }
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "jetbrains-rider", "Code", "jetbrains-studio" }
        },
        properties = {
            tag = tag_icons[2],
        },
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "firefox", "Google-chrome" }
        },
        properties = {
            tag = tag_icons[3],
        },
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "Thunar" }
        },
        properties = {
            tag = tag_icons[4],
        },
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "AppFlowy", "Zim" }
        },
        properties = {
            tag = tag_icons[6],
        },
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "Spotify", "vlc" }
        },
        properties = {
            tag = tag_icons[7],
        },
    })

    ruled.client.append_rule({
        rule_any   = {
            class = { "obs" }
        },
        properties = {
            tag = tag_icons[9],
        },
    })
end)
-- }}}

-- Focus the workspace when a client is assigned to a tag
client.connect_signal("manage", function(c)
    local t = c.first_tag
    if t then
        t:view_only()    -- Switch to that tag
        client.focus = c -- Focus the newly opened client
        c:raise()
    end
end)
