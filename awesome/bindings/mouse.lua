local awful = require("awful")
local gears = require("gears")

-- Set up client mouse bindings using the modern signal-based approach
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        -- Left-click on a client to focus
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        -- Modkey + Left-click to move a client
        awful.button({ modkey }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        -- Modkey + Right-click to resize a client
        awful.button({ modkey }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)

-- Root window mouse bindings
root.buttons(gears.table.join(
    -- Right-click on the desktop to toggle the main menu
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end),
    -- Scroll up / down to view previous / next tag
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
