--
-- print("Loading bundle.lua")
-- 

local side = nil
local monitor = nil

local debug = false
local debug_lines = 0
local debug_ystart = 0
local nr = 0

-- end vars

function setDebug(s, y)
	side = s
	debug_ystart = y

	if side ~= nil then
		if peripheral.getType( side ) == "monitor" then
			monitor = peripheral.wrap( side )
			term.redirect( monitor )
			term.clear()
			term.restore()
		else
			print( "No monitor on "..side.." side" )
			monitor = nil
		end
	else
		monitor = nil
	end
end

function enableDebug()
	debug = true
	clearDebug()
	debugPrint("Debug State: ", debug)
end

function disableDebug()
	debug = false
	clearDebug()
end

function toggleDebug()
	debug = not debug
	clearDebug()
	debugPrint("Debug State: ", debug)
end

function debugPrint(text, ... )
	if not debug then
		return
	end
	nr = nr + 1

	if monitor ~= nil then
		term.redirect( monitor )
	end
	
	term.setCursorPos(1, debug_ystart+debug_lines)
	print(nr, " ", text, ...)
	term.clearLine(debug_lines + 1)
	
	local w, h = term.getSize()
	debug_lines = (debug_lines + 1) % (h-debug_ystart)
	
	if monitor ~= nil then
		term.restore()
	end
end

function clearDebug()
	if monitor ~= nil then
		term.redirect( monitor )
	end

	local w, h = term.getSize()
	for i=debug_ystart,h-debug_ystart do
		term.clearLine(i)
	end

	if monitor ~= nil then
		term.restore()
	end
end
