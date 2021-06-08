--[[

--]]
local calc = require("calc")

local function main()
	local value = calc.get("1+2-3*4/5")
	-- print("-------")
	-- local value = calc.get("(1+2)*3")
	-- print("-------")
	-- local value = calc.get("(1+2)*(3-4)")
	-- print("-------")
	-- local value = calc.get("(1+2)*(3-4)/5.6")
	-- print("-------")
	-- local value = calc.get("7+(1+2)*(3-4)/5.6")
end

main()