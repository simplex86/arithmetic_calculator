--[[
	计算表达式的值
--]]
require("..core.const")
local lexer = require("..core.lexer")
local parser = require("..core.parser")

local operations = {
	[token_type.add] = function(a, b) return a + b end,
	[token_type.sub] = function(a, b) return a - b end,
	[token_type.mul] = function(a, b) return a * b end,
	[token_type.div] = function(a, b) return a / b end,
}

-- 获取语法树的值
local function _evaluation_(node)
	if node.type == token_type.number then
		node.value = tonumber(node.value)
	else
		local L = _evaluation_(node.lchild)
		local R = _evaluation_(node.rchild)
		local F = operations[node.type]
		node.value = F(L.value, R.value)
	end

	return node
end

-- 解析表达式，并返回结果值
-- debug：是否输出解析过程中的数据（词法栈和语法树）
local function _solve_(exp, debug)
	local tokens = lexer.solve(exp)
	local ast = parser.solve(tokens)

	if debug then
		lexer.print(tokens)
		parser.print(ast)
	end

	local result = _evaluation_(ast)
	return result.value
end

return {
	solve = _solve_,
}