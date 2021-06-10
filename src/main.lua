--[[

--]]
local exp_calc = require("calc.expression_calc")

local function _exp_calc_debug_(exp)
	print("---------------------------------------------")
	print("expression = " .. exp)
	print("---------------------------------------------")
	local value = exp_calc.solve(exp, true)
	print("---------------------------------------------")
	print("result = " .. value)
	print("---------------------------------------------")
	print("")
end

local function _exp_calc_release_(exp)
	local value = exp_calc.solve(exp)
	print(exp .. "=" .. value)
end

local _debug_ = false

local function main()
	local expc = _debug_ and _exp_calc_debug_ or _exp_calc_release_
	expc("1+2+3")
	expc("4-3-2")
	expc("4-(3-2)")
	expc("4-(3-2)*5")
	expc("(6+4)*2+(4-(3-2)*5)/7")
end

main()