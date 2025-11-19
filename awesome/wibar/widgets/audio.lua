local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

-- Nerd font icons
local volume_icons = {
	mute = "󰝟",
	low = "󰕿",
	mid = "󰖀",
	high = "󰕾",
}

local mic_icons = {
	on = "󰍬",
	off = "󰍭",
}

local audio_widget = wibox.widget({
	{
		{
			id = "vol_icon",
			markup = "󰖀",
			font = "Cascadia Code NF 18",
			widget = wibox.widget.textbox,
		},
		{
			id = "vol_value",
			markup = "...",
			font = "Cascadia Code NF 11",
			widget = wibox.widget.textbox,
		},
		spacing = 8,
		layout = wibox.layout.fixed.horizontal,
	},

	{
		{
			id = "mic_icon",
			markup = "󰍬",
			font = "Cascadia Code NF 18",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	},

	spacing = 15,
	layout = wibox.layout.fixed.horizontal,

	left = 8,
	right = 8,
	top = 4,
	bottom = 4,
	widget = wibox.container.margin,
})

----------------------------
-- 🟨 UPDATE VOLUME
----------------------------
local function update_volume()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(out)
		local vol = tonumber(out) or 0

		-- Check mute
		awful.spawn.easy_async_with_shell("pamixer --get-mute", function(m)
			local is_muted = m:match("true")

			-- Icon logic
			local icon
			if is_muted then
				icon = volume_icons.mute
			else
				if vol == 0 then
					icon = volume_icons.low
				elseif vol < 40 then
					icon = volume_icons.low
				elseif vol < 70 then
					icon = volume_icons.mid
				else
					icon = volume_icons.high
				end
			end

			audio_widget:get_children_by_id("vol_icon")[1].markup = "<span font='Cascadia Code NF 13'>"
				.. icon
				.. "</span>"

			audio_widget:get_children_by_id("vol_value")[1].markup = (is_muted and "M" or (vol .. "%"))
		end)
	end)
end

----------------------------
-- 🟨 UPDATE MICROPHONE
----------------------------
local function update_mic()
	awful.spawn.easy_async_with_shell("pamixer --default-source --get-mute", function(out)
		local is_muted = out:match("true")
		local icon = is_muted and mic_icons.off or mic_icons.on

		audio_widget:get_children_by_id("mic_icon")[1].markup = "<span font='Cascadia Code NF 13'>" .. icon .. "</span>"
	end)
end

----------------------------
-- 🔁 RUN TIMERS
----------------------------
gears.timer({
	timeout = 3,
	autostart = true,
	callback = function()
		update_volume()
		update_mic()
	end,
})

----------------------------
-- 🖱 MOUSE ACTIONS
----------------------------
audio_widget:buttons(gears.table.join(
	-- Scroll up = volume up
	awful.button({}, 4, function()
		awful.spawn("pamixer -i 5")
		update_volume()
	end),

	-- Scroll down = volume down
	awful.button({}, 5, function()
		awful.spawn("pamixer -d 5")
		update_volume()
	end),

	-- Left click = mute/unmute audio
	awful.button({}, 1, function()
		awful.spawn("pamixer -t")
		update_volume()
	end),

	-- Right click = mute/unmute mic
	awful.button({}, 3, function()
		awful.spawn("pamixer --default-source -t")
		update_mic()
	end)
))

awesome.connect_signal("audio::update", function()
	update_volume()
	update_mic()
end)

return audio_widget
