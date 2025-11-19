local wibox = require("wibox")

return wibox.widget({
	{
		format = " %a %b %d",
		align = "right",
		forced_width = 180,
		widget = wibox.widget.textclock,
	},
	left = 15,
	right = 10,
	top = 4,
	bottom = 4,
	widget = wibox.container.margin,
})
