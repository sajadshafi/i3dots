local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Import wibar widgets
local rofi_menu_widget = require("wibar.widgets.rofi")
local power_menu_widget = require("wibar.widgets.power")
local brightness_widget = require("wibar.widgets.brightness")
local audio_widget = require("wibar.widgets.audio")
local internet_widget = require("wibar.widgets.internet")
local battery_widget = require("wibar.widgets.battery")

local mytime = require("wibar.widgets.time")
local mydate = require("wibar.widgets.date")
local get_workspaces = require("wibar.widgets.workspaces")
local get_tasklist = require("wibar.widgets.tasklist")
local get_layouts = require("wibar.widgets.layoutbox")
local widget_helpers = require("wibar.widget_helpers")

-- Configuration
local modkey = "Mod4"
beautiful.systray_icon_spacing = 0
beautiful.systray_icon_size = 10

-- Wibar color scheme
local colors = {
	primary = "#C099FF",
	bg = "#222436",
	secondary = "#C099FF62",
	fg = "#fff4d2",
}

-- Helper functions to build wibar sections

-- Create left section with launcher and workspaces
---@param s screen
---@return table
local function create_left_section(s)
	return {
		layout = wibox.layout.fixed.horizontal,
		rofi_menu_widget,
		{
			get_workspaces(s, modkey),
			left = -18, -- Negative margin to overlap with launcher
			widget = wibox.container.margin,
		},
	}
end

-- Create center section with date, tasklist, and time
---@param s screen
---@return table
local function create_center_section(s)
	return {
		{
			{
				{
					{
						mydate,
						{
							{
								get_tasklist(s),
								widget = wibox.container.margin,
								left = 0,
								right = 20,
							},
							border_width = 0,
							border_color = colors.primary,
							bg = colors.bg,
							shape = widget_helpers.left_shape(),
							forced_width = 400,
							widget = wibox.container.background,
						},
						mytime,
						widget = wibox.layout.fixed.horizontal,
					},
					border_width = 2,
					border_color = "#22243654",
					shape = widget_helpers.center_border_shape(),
					bg = colors.secondary,
					fg = colors.fg,
					widget = wibox.container.background,
				},
				widget = wibox.container.place,
				halign = "left",
				valign = "left",
			},
			widget = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.place,
		halign = "center",
	}
end

-- Create right section with system widgets
---@param s screen
---@return table
local function create_right_section(s)
	return {
		widget = wibox.container.background,
		{
			widget = wibox.container.place,
			halign = "right",
			{
				layout = wibox.layout.fixed.horizontal,
				-- Audio widget
				widget_helpers.create_right_widget_box(140, audio_widget, 18),
				-- Brightness widget
				widget_helpers.create_right_widget_box(122, brightness_widget, 14),
				-- Battery widget
				widget_helpers.create_right_widget_box(122, battery_widget, 14),
				-- Internet widget
				widget_helpers.create_right_widget_box(180, internet_widget, 14),
				-- System tray
				widget_helpers.create_systray_box(),
				-- Layout box
				widget_helpers.create_layoutbox_container(get_layouts(s)),
				-- Power menu
				power_menu_widget,
			},
		},
	}
end

-- {{{ Wibar
---@diagnostic disable-next-line: undefined-global
screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table
	local tag_icons = { "", "", "󰈹", "", "󰭹", "󱓷", "", "", "" }
	awful.tag(tag_icons, s, awful.layout.layouts[1])

	-- Create the wibar
	s.mywibox = awful.wibar({
		position = "top",
		spacing = 10,
		margins = {
			top = 0,
			right = 0,
			bottom = 0,
			left = 0,
		},
		height = 35,
		screen = s,
		bg = "#00000000",
		border_radius = 8,
		widget = {
			layout = wibox.layout.align.horizontal,
			create_left_section(s),
			create_center_section(s),
			create_right_section(s),
		},
	})
end)

-- }}}
