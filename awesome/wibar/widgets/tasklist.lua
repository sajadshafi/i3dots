local awful = require("awful")
local wibox = require("wibox")

local get_tasklist = function(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		layout = {
			spacing = 0,
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							{
								id = "icon_role",
								widget = wibox.widget.imagebox,
							},
							{
								id = "text_role",
								widget = wibox.widget.textbox,
							},
							layout = wibox.layout.fixed.horizontal,
							spacing = 5,
						},
						left = 20,
						right = 4,
						top = 4,
						bottom = 4,
						widget = wibox.container.margin,
					},
					id = "background_role",
					widget = wibox.container.background,
				},
				widget = wibox.container.background,
			},
			-- give space so negative coords aren’t clipped
			widget = wibox.container.margin,
		},
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
			awful.button({}, 3, function()
				awful.menu.client_list({ theme = { width = 0 } })
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
	})
end

return get_tasklist
