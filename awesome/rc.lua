pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
require("wallpaper")
require("bindings")
require("widgets")
require("rules")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Error handling
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)
-- }}}

-- beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
beautiful.init("~/.config/awesome/theme-def.lua")
beautiful.useless_gap = dpi(3)
beautiful.font = "JetBrainsMono Nerd Font 12"
beautiful.border_radius = dpi(8)
beautiful.border_width = 2
beautiful.bg_systray = "#C099FF"

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("~/.config/awesome/theme-def.lua")

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
---@diagnostic disable-next-line: undefined-global
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.max,
		awful.layout.suit.fair,
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.floating,
	})
end)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
---@diagnostic disable-next-line: undefined-global
client.connect_signal("mouse::enter", function(c)
	c:activate({ context = "mouse_enter", raise = false })
end)

require("wibar")

awful.spawn.with_shell("sh ~/.config/awesome/launch.sh")
