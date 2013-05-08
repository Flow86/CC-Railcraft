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

function pulseBundledState(cable, color, state)
	setBundledState(cable, color, state)
	sleep(0.1)
	setBundledState(cable, color, not state)
end

function shallowcompare(a, b)
    local a_type = type(a)
    local b_type = type(b)
	
	if a_type ~= b_type then
		return false
	end
	
	if a_type == 'table' then
		for a_key, a_value in pairs(a) do
			if b[a_key] ~= a_value then
				return false
			end
		end
	else
		if a ~= b then
			return false
		end
	end
	
	return true;
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
