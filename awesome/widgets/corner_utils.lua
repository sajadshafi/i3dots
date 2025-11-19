local gears = require("gears")

-- Function to apply your shape
local function apply_octogonal_shape(c)
	c.shape = function(cr, w, h)
		gears.shape.octogon(cr, w, h, 20)
	end
end

-- Apply shape when a new client appears
---@diagnostic disable-next-line: undefined-global
client.connect_signal("manage", function(c)
	apply_octogonal_shape(c)
end)

-- Reapply shapes on restart (for existing windows)
---@diagnostic disable-next-line: undefined-global
awesome.connect_signal("startup", function()
	---@diagnostic disable-next-line: undefined-global
	for _, c in ipairs(client.get()) do
		apply_octogonal_shape(c)
	end
end)

---@diagnostic disable-next-line: undefined-global
awesome.connect_signal("refresh", function()
	---@diagnostic disable-next-line: undefined-global
	for _, c in ipairs(client.get()) do
		apply_octogonal_shape(c)
	end
end)
