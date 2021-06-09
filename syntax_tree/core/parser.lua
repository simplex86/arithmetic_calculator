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

local _atomic_exp_ 	= nil
local _mul_exp_		= nil
local _add_exp_ 	= nil

_atomic_exp_ = function(tokens, index)
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

_mul_exp_ = function(tokens, index)
	local node = _atomic_exp_(tokens, index)
	
	while tokens[index.value].type == token_type.mul or 
	      tokens[index.value].type == token_type.div 
	do
		index.value = index.value + 1

		local T = tokens[index.value - 1].type
		local L = node
		local R = _atomic_exp_(tokens, index)

		node = _create_node_(L, R, T)
	end

	return node
end

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

local function _print_(ast)
	print("parser output:")
end

return {
	solve = _solve_,
	print = _print_,
}