local awful = require("awful")
local wibox = require("wibox")

local get_workspaces = function(s, modkey)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = -18, -- let shape edges touch
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            forced_width = 40,
                            widget = wibox.widget.textbox,
                            align = "center",
                        },
                        left = 15,
                        right = 15,
                        top = 4,
                        bottom = 4,
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = wibox.container.background,
                },
                font = "Cascadia Code NF 10",
                border_width = 0,
                -- border_color = "#C099FF72",

                -- shifted, symmetrical tag shape
                shape = function(cr, w, h)
                    cr:move_to(18, 0) -- start shifted local brightness_widget = require("wibar.brightness")right
                    cr:line_to(w, 0) -- top-right
                    cr:line_to(w, h - 15) -- down to angled corner
                    cr:line_to(w - 18, h) -- bottom-right diagonal
                    cr:line_to(0, h) -- bottom-left diagonal
                    cr:line_to(17, h - 15)
                    cr:line_to(17, 0)
                    cr:close_path()
                end,

                widget = wibox.container.background,
            },
            -- give space so negative coords aren’t clipped
            widget = wibox.container.margin,
        },
        buttons = {
            awful.button({}, 1, function(t)
                t:view_only()
            end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end),
        },
    })
end

return get_workspaces
