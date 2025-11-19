---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Cascadia Code NF 10"
theme.bg_normal = "#222436"
theme.bg_focus = "#C099FF"
theme.bg_urgent = "#eba0ac"
theme.bg_minimize = "#313244"
theme.bg_systray = "#FFF4D2"

theme.fg_normal = "#C099FF"
theme.fg_focus = "#fff4d2"
theme.fg_urgent = "#C099FF"
theme.fg_minimize = "#99d1db"

theme.useless_gap = dpi(3)
theme.border_normal = "#c98b9f"
theme.border_focus = "#C099FF"
theme.border_marked = "#1e1e2e"
theme.border_radius = dpi(8)
theme.border_width = dpi(2)

theme.menu_height = 30
theme.menu_width = 120
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_fg_urgent = theme.fg_urgent

theme.tasklist_fg_normal = "#fff4d2"
theme.tasklist_fg_focus = "#C099FF"
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_bg_focus = "#00000000"

-- {{{ Layout
theme.layout_fairv = "~/.config/awesome/layouts/fairhw.png"
theme.layout_dwindle = "~/.config/awesome/layouts/dwindlew.png"
theme.layout_max = "~/.config/awesome/layouts/max_tab.png"
theme.layout_magnifier = "~/.config/awesome/layouts/magnifierw.png"
theme.layout_floating = "~/.config/awesome/layouts/floatingw.png"
-- }}}

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

--Signals
client.connect_signal("focus", function(c)
	c.border_color = theme.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = theme.border_normal
end)

theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
