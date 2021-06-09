--[[

--]]
local calc = require("calc")

local expressions = {
	"1+2",
	"4-3-2",
	"4-(3-2)",
	"4-(3-2)*5",
}

local function main()
	for _, exp in pairs(expressions) do
		print("solve " .. exp)
		local value = calc.solve(exp)
		print("result " .. value)
		print("")
	end
end

main()