-- ~/.config/awesome/rules/tags.lua

local awful = require("awful")
local beautiful = require("beautiful")

-- App → Tag assignment rules
local app_tag_rules = {
    -- 1: Terminal apps
    { rule = { class = "kitty" },                     properties = { tag = "1" } },
    { rule = { class = "alacritty" },                 properties = { tag = "1" } },
    { rule = { class = "wezterm" },                   properties = { tag = "1" } },

    -- 2: Coding (VSCode, JetBrains Rider, etc.)
    { rule = { class = "code" },                      properties = { tag = "2" } },
    { rule = { class = "jetbrains-rider" },           properties = { tag = "2" } },
    { rule = { class = "jetbrains-idea" },            properties = { tag = "2" } },
    { rule = { class = "jetbrains-studio" },          properties = { tag = "2" } },

    -- 3: Browsers
    { rule = { class = "firefox" },                   properties = { tag = "3" } },
    { rule = { class = "Google-chrome" },             properties = { tag = "3" } },
    { rule = { class = "Chromium" },                  properties = { tag = "3" } },

    -- 4: File managers
    { rule = { class = "thunar" },                    properties = { tag = "4" } },
    { rule = { class = "nemo" },                      properties = { tag = "4" } },
    { rule = { class = "nautilus" },                  properties = { tag = "4" } },
    { rule = { class = "org.gnome.Nautilus" },        properties = { tag = "4" } },

    -- 5: Chat apps
    { rule = { class = "discord" },                   properties = { tag = "5" } },
    { rule = { class = "Microsoft Teams - Preview" }, properties = { tag = "5" } },
    { rule = { class = "teams" },                     properties = { tag = "5" } },
    { rule = { class = "Slack" },                     properties = { tag = "5" } },

    -- 6: Notes apps
    { rule = { class = "appflowy" },                  properties = { tag = "6" } },
    { rule = { class = "obsidian" },                  properties = { tag = "6" } },

    -- 7: Music / Media
    { rule = { class = "spotify" },                   properties = { tag = "7" } },
    { rule = { class = "vlc" },                       properties = { tag = "7" } },
}

awful.rules.rules = {
    -- Default rules
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            -- keys         = clientkeys,
            -- buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Import your tag rules
    table.unpack(app_tag_rules),
}
