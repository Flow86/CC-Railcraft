--
-- print("Loading bundle.lua")
--

function setBundledState(cable, color, state)
	local oldcolor = rs.getBundledOutput(cable)

	if state then
		oldcolor = colors.combine(oldcolor, color)
	else
		oldcolor = colors.subtract(oldcolor, color)
	end

	rs.setBundledOutput(cable, oldcolor)
end
