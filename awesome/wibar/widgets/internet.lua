local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Trim SSID
local function shorten(str, len)
	len = len or 12
	if not str then
		return ""
	end
	if #str <= len then
		return str
	end
	return str:sub(1, len) .. "…"
end

-- Signal icon
local function wifi_signal_icon(pct)
	pct = tonumber(pct) or 0
	if pct >= 80 then
		return "󰤨 "
	elseif pct >= 60 then
		return "󰤥 "
	elseif pct >= 40 then
		return "󰤢 "
	elseif pct >= 20 then
		return "󰤟 "
	else
		return "󰤯 "
	end
end

local ethernet_icon = "󰈀 "

-- Widgets
local neticon = wibox.widget.textbox()
local nettext = wibox.widget.textbox()

local widget = wibox.widget({
	{
		neticon,
		nettext,
		spacing = 6,
		layout = wibox.layout.fixed.horizontal,
	},
	left = 10,
	right = 10,
	top = 4,
	bottom = 4,
	widget = wibox.container.margin,
})

------------------------------------------------------------
-- Speed calculation
------------------------------------------------------------

local last_rx, last_tx, last_time = 0, 0, os.time()

local function calc_speed(rx, tx)
	local now = os.time()
	local dt = now - last_time
	if dt == 0 then
		return "0K", "0K"
	end

	local rx_s = (rx - last_rx) / dt
	local tx_s = (tx - last_tx) / dt

	last_rx, last_tx, last_time = rx, tx, now

	local function fmt(b)
		if b < 1024 then
			return string.format("%dB", b)
		elseif b < 1024 * 1024 then
			return string.format("%.1fK", b / 1024)
		else
			return string.format("%.1fM", b / (1024 * 1024))
		end
	end

	return fmt(rx_s), fmt(tx_s)
end

------------------------------------------------------------
-- Update function
------------------------------------------------------------

local function update()
	awful.spawn.easy_async_with_shell(
		[=[
        # Get WiFi device, SSID, signal %
        WIFI_DEV=$(nmcli -t -f DEVICE,TYPE dev | awk -F: '$2=="wifi"{print $1; exit}')
        WIFI_SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}')
        WIFI_SIGNAL=$(nmcli -t -f IN-USE,SIGNAL dev wifi | awk -F: '$1=="*"{print $2; exit}')
        WIFI_STATE=$(nmcli -t -f DEVICE,STATE dev | awk -F: -v d="$WIFI_DEV" '$1==d{print $2}')

        # Get Wired device
        WIRED_DEV=$(nmcli -t -f DEVICE,TYPE dev | awk -F: '$2=="ethernet"{print $1; exit}')
        WIRED_STATE=$(nmcli -t -f DEVICE,STATE dev | awk -F: -v d="$WIRED_DEV" '$1==d{print $2}')

        # Wired connected?
        if [[ "$WIRED_STATE" == "connected" ]]; then
            RX=$(cat /sys/class/net/$WIRED_DEV/statistics/rx_bytes)
            TX=$(cat /sys/class/net/$WIRED_DEV/statistics/tx_bytes)
            echo "wired::$RX:$TX"
            exit 0
        fi

        # WiFi connected?
        if [[ "$WIFI_STATE" == "connected" ]] && [[ -n "$WIFI_SSID" ]]; then
            RX=$(cat /sys/class/net/$WIFI_DEV/statistics/rx_bytes)
            TX=$(cat /sys/class/net/$WIFI_DEV/statistics/tx_bytes)
            echo "wifi:$WIFI_SSID:$WIFI_SIGNAL:$RX:$TX"
            exit 0
        fi

        echo "down"
    ]=],
		function(out)
			local t = {}
			for v in string.gmatch(out, "([^:]+)") do
				table.insert(t, v)
			end

			if t[1] == "wired" then
				local rx, tx = tonumber(t[3]) or 0, tonumber(t[4]) or 0
				local down, up = calc_speed(rx, tx)
				neticon.text = ethernet_icon
				nettext.text = string.format("WIRED")
			elseif t[1] == "wifi" then
				local ssid = shorten(t[2])
				local signal = tonumber(t[3]) or 0
				local rx, tx = tonumber(t[4]) or 0, tonumber(t[5]) or 0
				local down, up = calc_speed(rx, tx)
				neticon.text = wifi_signal_icon(signal)
				nettext.text = string.format("%s", ssid)
			else
				neticon.text = "󰤮 "
				nettext.text = "Disconnected"
			end
		end
	)
end

------------------------------------------------------------
-- Timer
------------------------------------------------------------

gears.timer({
	timeout = 1,
	autostart = true,
	call_now = true,
	callback = update,
})

return widget
