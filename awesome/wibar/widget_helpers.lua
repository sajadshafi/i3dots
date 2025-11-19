-- Widget helper utilities for wibar
local wibox = require("wibox")

local M = {}

-- Shape function for right-aligned widgets with diagonal corners
function M.right_shape()
    return function(cr, w, h)
        cr:move_to(0, 0)
        cr:line_to(w - 18, 0) -- top-right
        cr:line_to(w - 18, h - 15) -- down to angled corner
        cr:line_to(w, h)     -- bottom-right diagonal
        cr:line_to(18, h)    -- bottom-left diagonal
        cr:line_to(0, h - 15)
        cr:close_path()
    end
end

-- Shape function for left-aligned widgets with diagonal corners
function M.left_shape()
    return function(cr, w, h)
        cr:move_to(0, 0)
        cr:line_to(w + 2, 0) -- top-right
        cr:line_to(w + 2, h - 16) -- down to angled corner
        cr:line_to(w - 18, h) -- bottom-right diagonal
        cr:line_to(19, h)   -- bottom-left diagonal
        cr:line_to(0, h - 16)
        cr:line_to(0, 0)
        cr:close_path()
    end
end

-- Shape function for center/border container
function M.center_border_shape()
    return function(cr, w, h)
        cr:move_to(0, 0)
        cr:line_to(w + 2, 0)
        cr:line_to(w + 2, h - 16)
        cr:line_to(w - 18, h)
        cr:line_to(19, h)
        cr:line_to(0, h - 16)
        cr:close_path()
    end
end

-- Create a shaped container for right-aligned widgets
-- @param width: forced width of container
-- @param content: widget or table of widgets
-- @param left_margin: left margin for content (default 14)
function M.create_right_widget_box(width, content, left_margin)
    left_margin = left_margin or 14
    return {
        {
            forced_width = width,
            widget = wibox.container.background,
            fg = "#C099FF",
            bg = "#222436",
            shape = M.right_shape(),
            {
                widget = wibox.container.margin,
                left = left_margin,
                right = 5,
                content,
            },
        },
        widget = wibox.container.margin,
        right = -19,
    }
end

-- Create the systray container
function M.create_systray_box()
    return {
        widget = wibox.container.margin,
        right = -18,
        {
            forced_width = 100,
            widget = wibox.container.background,
            bg = "#C099FF",
            shape = M.right_shape(),
            {
                widget = wibox.container.margin,
                left = 10,
                right = 10,
                {
                    valign = "center",
                    halign = "center",
                    margins = 14,
                    widget = wibox.container.place,
                    {
                        widget = wibox.widget.systray(),
                        base_size = 26,
                        spacing = 25,
                    },
                },
            },
        },
    }
end

-- Create the layout box container
function M.create_layoutbox_container(layoutbox_widget)
    return {
        widget = wibox.container.margin,
        left = 0,
        right = -19,
        {
            bg = "#222436",
            shape = M.right_shape(),
            forced_width = 80,
            widget = wibox.container.background,
            {
                widget = wibox.container.margin,
                left = 20,
                right = 20,
                layoutbox_widget,
            },
        },
    }
end

return M
