--[[
	计算器
--]]
local lexer = require("core.lexer")
local parser = require("core.parser")

-- 打印tokens列表
local function _print_tokens_(tokens)
	print("syntax stack:")
	for k, v in pairs(tokens) do
		print(string.format("%s: \t%s\t%s", k, v.value, v.type))
	end
end

-- 打印tokens列表
local function _print_tree_(tree)

end

-- 获取语法树的值
local function _evaluation_(tree)

end

local function _calc_(exp)
	local tokens = lexer.solve(exp)
	_print_tokens_(tokens)
	local tree = parser.solve(tokens)
	_print_tree_(tree)

	return _evaluation_(tree)
end

return {
	get = _calc_,
}