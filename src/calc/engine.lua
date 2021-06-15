--[[
    计算器
]]
local lexer  = require("..core.lexer")
local parser = require("..core.parser")
local expc   = require("calc.internal.expression_calc")
local fmlc   = require("calc.internal.formula_calc")

-- 求表达式的值
local function _calc_(exp, vars, debug)
    local tokens = lexer.solve(exp)
	local ast = parser.solve(tokens)

	if debug then
		lexer.print(tokens)
		parser.print(ast)
	end

    if vars == nil then
        return expc.evaluation(ast)
    end

    return fmlc.evaluation(ast, vars)
end

return {
    calc = _calc_,
}