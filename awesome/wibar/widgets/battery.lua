local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local icon = wibox.widget.textbox()
icon.font = "JetBrainsMono Nerd Font 14"

local text = wibox.widget.textbox()
text.font = "JetBrainsMono Nerd Font 11"

local widget = wibox.widget({
	icon,
	text,
	spacing = 6,
	layout = wibox.layout.fixed.horizontal,
})

-- Find battery device (BAT0 / BAT1)
local function detect_battery()
	local handle = io.popen("ls /sys/class/power_supply | grep -E 'BAT'")
	if handle then
		local result = handle:read("*l")
		handle:close()
		return result or "BAT0"
	end
	return "BAT0"
end

local BAT = detect_battery()

-- Battery icons by level
local function battery_icon(level, status)
	level = tonumber(level) or 0

	if status == "Charging" then
		return "󰂄 " -- charging icon
	end

	if level >= 90 then
		return " "
	end
	if level >= 70 then
		return " "
	end
	if level >= 50 then
		return " "
	end
	if level >= 30 then
		return " "
	end
	if level >= 15 then
		return " "
	end
	return " " -- critically low
end

local function update_widget()
	awful.spawn.easy_async_with_shell([=[
        BAT="]=] .. BAT .. [=["
        CAP=$(cat /sys/class/power_supply/$BAT/capacity)
        STAT=$(cat /sys/class/power_supply/$BAT/status)

        echo "$CAP:$STAT"
    ]=], function(out)
		local cap, stat = out:match("(%d+):(%a+)")
		cap = tonumber(cap)

		-- Set icons
		icon.text = battery_icon(cap, stat)
		text.text = cap .. "%"

		-- (Optional) Color based on level
		if cap <= 15 then
			text.markup = "<span foreground='#ff4d4d'>" .. cap .. "%</span>"
		else
			text.markup = "<span foreground='#C099FF'>" .. cap .. "%</span>"
		end
	end)
end

-- Update every 5 sec (battery doesn't need faster)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = update_widget,
})

return widget
