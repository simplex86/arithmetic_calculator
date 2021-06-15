--[[

--]]
local exp_calc = require("calc.expression_calc")
local fml_calc = require("calc.formula_calc")

local _debug_ = false

local function _exp_calc_(exp)
	local value = exp_calc.solve(exp, _debug_)
	print(exp .. "=" .. value)
end

local function _fml_calc_(formula, vars)
	local value = fml_calc.solve(formula, vars, _debug_)
	local vtext = ""
	for k, v in pairs(vars) do
		if vtext ~= "" then
			vtext = vtext .. ","
		end
		vtext = vtext .. k .. "=" .. v
	end
	print(formula .. "=" .. value .. " {" .. vtext .. "}")
end



local function main()
	local expc = _exp_calc_
	expc("1+2+3")
	expc("4-3-2")
	expc("4-(3-2)")
	expc("4-(3-2)*5")
	expc("(6+4)*2+(4-(3-2)*5)/7")
	expc("1+2^3+4")
	expc("(1+2)^3+4")

	local fmlc = _fml_calc_
	fmlc("a+(b-c)", {a=1, b=2, c=3})
end

main()