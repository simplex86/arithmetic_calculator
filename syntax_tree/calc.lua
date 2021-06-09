--[[
	计算器
--]]
require("core.const")
local lexer = require("core.lexer")
local parser = require("core.parser")

local operations = {
	[token_type.add] = function(a, b) return a + b end,
	[token_type.sub] = function(a, b) return a - b end,
	[token_type.mul] = function(a, b) return a * b end,
	[token_type.div] = function(a, b) return a / b end,
}

-- 获取语法树的值
local function _evaluation_(ast)

end

local function _calc_(exp)
	local tokens = lexer.solve(exp)
	lexer.print(tokens)
	local ast = parser.solve(tokens)
	parser.print(ast)

	return _evaluation_(ast)
end

return {
	get = _calc_,
}