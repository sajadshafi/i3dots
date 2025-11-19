local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local icons = {
	low = "󰃞",
	mid = "󰃟",
	high = "󰃠",
}

local brightness_widget = wibox.widget({
	{
		{
			id = "icon",
			markup = "󰃟",
			font = "Cascadia Code NF 13",
			widget = wibox.widget.textbox,
		},
		{
			id = "value",
			markup = "...",
			font = "Cascadia Code NF 11",
			widget = wibox.widget.textbox,
		},
		spacing = 6,
		layout = wibox.layout.fixed.horizontal,
	},
	left = 8,
	right = 8,
	top = 4,
	bottom = 4,
	widget = wibox.container.margin,
})

local function update_widget()
	awful.spawn.easy_async_with_shell("brightnessctl -m | cut -d, -f4 | tr -d '%'", function(out)
		local br = tonumber(out) or 0

		-- Select icon
		local icon = icons.mid
		if br < 30 then
			icon = icons.low
		end
		if br > 70 then
			icon = icons.high
		end

		brightness_widget:get_children_by_id("icon")[1].markup =
			string.format("<span font='Cascadia Code NF 18'>%s</span>", icon)

		brightness_widget:get_children_by_id("value")[1].markup = br .. "%"
	end)
end

gears.timer({
	timeout = 3,
	autostart = true,
	callback = update_widget,
})

brightness_widget:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn("brightnessctl set +5%")
		update_widget()
	end),
	awful.button({}, 3, function()
		awful.spawn("brightnessctl set 5%-")
		update_widget()
	end)
))

awesome.connect_signal("brightness::update", function()
	update_widget()
end)

return brightness_widget
