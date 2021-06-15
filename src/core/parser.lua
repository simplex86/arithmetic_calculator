--[[
	语法分析
]]
require("core.const")

-- 构建节点
local function _create_node_(lchild, rchild, type, value)
	local node = {
		lchild = lchild,
		rchild = rchild,
		type   = type,
		value  = value,
	}

	return node
end

-- 比较token类型是否是指定的类型
local function _match_token_type_(tokens, index, type)
	if tokens[index.value].type ~= type then
		error("parser error: ")
	end

	index.value = index.value + 1
end

local _number_exp_ 	= nil
local _pow_exp_ 	= nil
local _mul_exp_		= nil
local _add_exp_ 	= nil

-- 数字表达式
_number_exp_ = function(tokens, index)
	local node = nil

	local token = tokens[index.value]
	if token.type == token_type.parenthese_left then
		index.value = index.value + 1
		node = _add_exp_(tokens, index)
		_match_token_type_(tokens, index, token_type.parenthese_right)
	elseif token.type == token_type.number then
		node = _create_node_(nil, nil, token.type, token.value)
		index.value = index.value + 1
	else
		error("parser error")
	end

	return node
end

-- 幂表达式
_pow_exp_ = function(tokens, index)
	local node = _number_exp_(tokens, index)
	
	while tokens[index.value].type == token_type.pow do
		index.value = index.value + 1

		local T = tokens[index.value - 1].type
		local L = node
		local R = _number_exp_(tokens, index)

		node = _create_node_(L, R, T)
	end

	return node
end

-- 乘除表达式
_mul_exp_ = function(tokens, index)
	local node = _pow_exp_(tokens, index)
	
	while tokens[index.value].type == token_type.mul or 
	      tokens[index.value].type == token_type.div 
	do
		index.value = index.value + 1

		local T = tokens[index.value - 1].type
		local L = node
		local R = _pow_exp_(tokens, index)

		node = _create_node_(L, R, T)
	end

	return node
end

-- 加减表达式
_add_exp_ = function(tokens, index)
	local node = _mul_exp_(tokens, index)

	while tokens[index.value].type == token_type.add or 
		  tokens[index.value].type == token_type.sub 
	do
		index.value = index.value + 1

		local T = tokens[index.value - 1].type
		local L = node
		local R = _mul_exp_(tokens, index)

		node = _create_node_(L, R, T)
	end

	return node
end

-- 构建语法树
local function _solve_(tokens)
	local idx = { value = 1 }
	local ast = _add_exp_(tokens, idx)

	if #tokens > idx.value then
		error("parser error: ")
	end

	return ast
end

local _type_2_char_map_ = {
	[token_type.add] 				= "+",
	[token_type.sub] 				= "-",
	[token_type.mul] 				= "*",
	[token_type.div] 				= "/",
}

-- 把树格式化为字符串
local function _format_node_(node, depth)
	local text = ""

	if node.type == token_type.number then
		text = string.rep("   ", depth) .. node.value .. "\n"
		return text
	end

	text = text .. string.rep("   ", depth) .. _type_2_char_map_[node.type] .. "\n"

	text = text .. _format_node_(node.lchild, depth + 1)
	text = text .. _format_node_(node.rchild, depth + 1)

	return text
end

-- 打印
local function _print_(node)
	local text = _format_node_(node, 0)
	print("parser output:\n" .. text)
end

return {
	solve = _solve_,
	print = _print_,
}