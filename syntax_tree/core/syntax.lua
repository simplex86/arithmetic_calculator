--[[
	语法树
]]
local const = require("core.const")

-- 构建节点
local function _create_node_()
	local node = {
		lchild = nil,
		rchild = nil,
		token = token_type.none,
	}

	return node
end

-- 构建语法树
local function _solve_(tokens)
	local tree = _create_node_()

	return tree
end

return {
	solve = _solve_,
}