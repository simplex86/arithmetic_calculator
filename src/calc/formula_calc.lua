--[[
    公式计算器
]]
require("..util.string")
require("..core.const")
local exp_calc = require("calc.expression_calc")

local function _formula_to_expression_(formula, vars)
    local exp = formula
    for k, v in pairs(vars) do
        exp = string.replace(exp, k, v, true)
    end

    return exp
end

local function _solve_(formula, vars, debug)
    local exp = _formula_to_expression_(formula, vars)
	return exp_calc.solve(exp, debug)
end

return {
	solve = _solve_,
}