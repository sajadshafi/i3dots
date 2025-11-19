local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local power_menu_widget = wibox.widget({
	{
		{
			text = "⏼", -- Arch Nerd Font icon
			font = "Cascadia Code NF 18",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},

		forced_width = 100,
		forced_height = 32,
		widget = wibox.container.background,
	},
	bg = "#181825",
	fg = "#C099FF",
	border_color = "#C099FF72",
	border_width = 2,
	shape = function(cr, w, h)
		local cut = 15
		cr:move_to(0, 0)
		cr:line_to(w, 0)
		cr:line_to(w, h)
		cr:line_to(18, h)
		cr:line_to(0, h - 15)
		cr:line_to(0, 0)
		cr:close_path()
	end,
	margins = {
		right = 20,
	},
	widget = wibox.container.background,
})

power_menu_widget:buttons(gears.table.join(awful.button({}, 1, function()
	awful.spawn.with_shell("~/.config/rofi/scripts/powermenu.sh")
end)))

return power_menu_widget
