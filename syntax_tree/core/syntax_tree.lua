--[[
	语法树
]]
local syntax_stack = require("syntax_tree.syntax_stack")
local syntax_token = require("syntax_tree.syntax_token")
local syntax_tree_node = require("syntax_tree.syntax_tree_node")
local syntax_const = require("syntax_tree.syntax_const")

-- 扫描表达式，构建语法栈
local function _scan_(exp)
	local stack = syntax_stack.new()
	
	local spt = 1
	local ept = 1
	
	while ept <= #exp do		
		local c = string.sub(exp, ept, ept)
		if c == "+" or
		   c == "-" or
		   c == "*" or
		   c == "/" or
		   c == "(" or
		   c == ")"
		then
			if ept > spt then
				local v = string.sub(exp, spt, ept-1)
				local token = syntax_token.new(syntax_token_type.number, v)
				stack.push(token)
			end
			
			local token = syntax_token.new(syntax_token_type.operator, c)
			stack.push(token)

			spt = ept + 1
		end
		
		ept = ept + 1
	end

	if ept > spt then
		local v = string.sub(exp, spt, ept-1)
		local token = syntax_token.new(syntax_token_type.number, v)
		stack.push(token)
	end
	
	return stack
end

-- 构建语法树
local function _ctor_(stack)

end

-- 获取语法树的值
local function _evaluation_(tree)

end

-- 求解
local function _solve_(exp)
	local stack = _scan_(exp)
	stack.output()
	local tree = _ctor_(stack)
	
	return _evaluation_(tree)
end

local function _new_()
	local tree = {
		solve = function(exp) return _solve_(exp) end,
	}
	
	return tree
end

return {
	new = _new_,
}