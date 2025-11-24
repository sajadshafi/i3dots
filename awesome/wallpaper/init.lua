local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

beautiful.wallpaper = "/usr/share/backgrounds/bg-8.png"

---@diagnostic disable-next-line: undefined-global
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
        screen = s,
        widget = {
            image = gears.surface.crop_surface({
                surface = gears.surface.load_uncached(beautiful.wallpaper),
                ratio = s.geometry.width / s.geometry.height,
            }),
            widget = wibox.widget.imagebox,
        },
    })
end)
