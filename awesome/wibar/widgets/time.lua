local wibox = require("wibox")

return wibox.widget({
	{
		format = "%H:%M %p 󱑂",
		align = "left",
		forced_width = 150,
		widget = wibox.widget.textclock,
	},
	left = 10,
	right = 15,
	top = 4,
	bottom = 4,
	widget = wibox.container.margin,
})
