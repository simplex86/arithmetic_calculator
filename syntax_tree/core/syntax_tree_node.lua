--[[
	语法树节点
--]]
local syntax_const = require("syntax_tree.syntax_const")

local function _new_()
	local node = {
		lchild = nil,
		rchild = nil,
		token = syntax_tree_token_type.number,
	}
end

return {
	new = _new,
}