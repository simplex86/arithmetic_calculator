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
		error("parser error: ")
	end

	return node
end

-- 幂表达式
_pow_exp_ = function(tokens, index)

end

-- 乘除表达式
_mul_exp_ = function(tokens, index)
	local node = _number_exp_(tokens, index)
	
	while tokens[index.value].type == token_type.mul or 
	      tokens[index.value].type == token_type.div 
	do
		index.value = index.value + 1

		local T = tokens[index.value - 1].type
		local L = node
		local R = _number_exp_(tokens, index)

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
	[token_type.parenthese_left] 	= "(",
	[token_type.parenthese_right] 	= ")",
}

local function _get_depth_(node)
	return 8
end

local function _format_node_(node, level)
	if node.type == token_type.ending or
	   node.type == token_type.parenthese_right
	then
		return ""
	end

	if node.type == token_type.parenthese_left then
		_format_node_(node.lchild, level)
		_format_node_(node.rchild, level)
		return ""
	end

	if node.type == token_type.number then
		print(string.rep("\t", level) .. node.value)
		return
	end

	print(string.rep("\t", level) .. _type_2_char_map_[node.type])

	_format_node_(node.lchild, level-1)
	_format_node_(node.rchild, level+1)
end

local function _print_(node)
	print("parser output:")

	local level = _get_depth_(node)
	_format_node_(node, level)
end

return {
	solve = _solve_,
	print = _print_,
}