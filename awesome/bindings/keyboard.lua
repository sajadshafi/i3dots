-- Required libraries
local awful = require("awful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- Default modkey.
-- Modkey: Mod4 (Super key) or Mod1 (Alt key)
local modkey = "Mod4"

local terminal = "kitty"
local browser = "firefox"
local filemanager = "thunar"

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	-- awful.key({ modkey, "Shift" }, "w", function()
	-- 	mymainmenu:show()
	-- end, { description = "show main menu", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "p", awesome.quit, { description = "quit awesome", group = "awesome" }),
})

-- Launcher Keybindings
awful.keyboard.append_global_keybindings({

	-- Launch terminal
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "terminal", group = "launcher" }),

	-- launch Rofi menu
	awful.key({ modkey }, "d", function()
		awful.spawn("rofi -show drun")
	end, { description = "rofi", group = "launcher" }),

	-- Launch File Manager (Thunar)
	awful.key({ modkey }, "n", function()
		awful.spawn(filemanager)
	end, { description = "file manager", group = "launcher" }),

	-- Launch Browser (Firefox)
	awful.key({ modkey }, "w", function()
		awful.spawn(browser)
	end, { description = "Launch browser", group = "launcher" }),

	-- launch power menu (customized ROFI)
	awful.key({ modkey }, "p", function()
		awful.spawn.with_shell("~/.config/rofi/scripts/powermenu.sh")
	end, { description = "Launch power menu (custom rofi)", group = "launcher" }),
})

-- Utility Shortcuts
awful.keyboard.append_global_keybindings({

	-- Screenshot full screen (Print)
	awful.key({}, "Print", function()
		awful.spawn.with_shell(
			"flameshot screen -n 0 -p ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H%M%S)-screenshot.png"
		)
	end, { description = "take fullscreen screenshot", group = "screenshots" }),

	-- Screenshot selection (Mod+Shift+S)
	awful.key({ modkey, "Shift" }, "s", function()
		awful.spawn.with_shell("QT_ENABLE_HIGHDPI_SCALING=0 flameshot gui")
	end, { description = "take area screenshot", group = "screenshots" }),

	-- brightness up (5%)
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("~/.config/scripts/brightness.sh up")
		awesome.emit_signal("brightness::update")
	end, { description = "Increase brightness by 5%", group = "utility" }),

	-- brightness down (5%)
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("~/.config/scripts/brightness.sh down")
		awesome.emit_signal("brightness::update")
	end, { description = "Decrease brightness by 5%", group = "utility" }),

	-- brightness up (2%)
	awful.key({ "Shift" }, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("~/.config/scripts/brightness.sh up 2")
		awesome.emit_signal("brightness::update")
	end, { description = "Increase brightness by 2%", group = "utility" }),

	-- brightness down (2%)
	awful.key({ "Shift" }, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("~/.config/scripts/brightness.sh down 2")
		awesome.emit_signal("brightness::update")
	end, { description = "Decrease brightness by 2%", group = "utility" }),

	-- volume up (5%)
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("~/.config/scripts/volume.sh up")
		awesome.emit_signal("audio::update")
	end, { description = "Decrease volume by 2%", group = "utility" }),

	-- volume down (5%)
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("~/.config/scripts/volume.sh down")
		awesome.emit_signal("audio::update")
	end, { description = "Decrease volume by 2%", group = "utility" }),

	-- volume up (2%)
	awful.key({ "Shift" }, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("~/.config/scripts/volume.sh down 2")
		awesome.emit_signal("audio::update")
	end, { description = "Decrease volume by 2%", group = "utility" }),

	-- volume down (2)
	awful.key({ "Shift" }, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("~/.config/scripts/volume.sh down 2")
		awesome.emit_signal("audio::update")
	end, { description = "Decrease volume by 2%", group = "utility" }),

	-- Mute
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("~/.config/scripts/volume.sh mute")
		awesome.emit_signal("audio::update")
	end, { description = "Mute the audio", group = "utility" }),

	-- Mute Mic
	awful.key({}, "XF86AudioMicMute", function()
		awful.spawn.with_shell("amixer sset Capture toggle")
		awesome.emit_signal("audio::update")
	end, { description = "Mute Mic", group = "utility" }),

	-- Play/Pause Audio
	awful.key({}, "XF86AudioPlay", function()
		awful.spawn.with_shell("playerctl play-pause")
	end, { description = "Play/Pause audio", group = "utility" }),

	-- Next Audio
	awful.key({}, "XF86AudioNext", function()
		awful.spawn.with_shell("playerctl next")
	end, { description = "Go Next audio", group = "utility" }),

	-- Prev Audio
	awful.key({}, "XF86AudioPrev", function()
		awful.spawn.with_shell("playerctl previous")
	end, { description = "Goto Previous audio", group = "utility" }),

	-- Lock screen
	awful.key({ modkey, "Shift" }, "l", function()
		awful.spawn.with_shell("betterlockscreen -l dimblur")
	end, { description = "Lock screen using betterlockscreen", group = "utility" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ modkey, "Shift" }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey, "Shift" }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({

	awful.key({ modkey }, "Right", function()
		if awful.layout.get(mouse.screen) == awful.layout.suit.max then
			awful.client.focus.byidx(1)
		else
			awful.client.focus.global_bydirection("right")
		end
	end, { description = "focus next client", group = "client" }),

	-- awful.client.focus.bydirection("right")
	-- end, { description = "focus next by index", group = "client" }),

	awful.key({ modkey }, "Left", function()
		if awful.layout.get(mouse.screen) == awful.layout.suit.max then
			awful.client.focus.byidx(-1)
		else
			awful.client.focus.global_bydirection("left")
		end
	end, { description = "focus previous by index", group = "client" }),

	awful.key({ modkey }, "Up", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus next by index", group = "client" }),

	awful.key({ modkey }, "Down", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus previous by index", group = "client" }),

	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		---@diagnostic disable-next-line: undefined-global
		if client.focus then
			---@diagnostic disable-next-line: undefined-global
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({

	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	awful.key({
		modifiers = { modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			---@diagnostic disable-next-line: undefined-global
			if client.focus then
				---@diagnostic disable-next-line: undefined-global
				local tag = client.focus.screen.tags[index]
				if tag then
					---@diagnostic disable-next-line: undefined-global
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})

-- -- {{{ Key bindings
---@diagnostic disable-next-line: undefined-global
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({

		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),

		awful.key({ modkey }, "q", function(c)
			c:kill()
		end, { description = "close", group = "client" }),

		awful.key(
			{ modkey },
			"space",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),

		awful.key({ modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),

		awful.key({ modkey }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "(un)maximize", group = "client" }),
	})
end)

-- }}}
