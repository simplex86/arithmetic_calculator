--[[

]]
require("....core.const")

local operations = {
	[token_type.add] = function(a, b) return a + b end,
	[token_type.sub] = function(a, b) return a - b end,
	[token_type.mul] = function(a, b) return a * b end,
	[token_type.div] = function(a, b) return a / b end,
	[token_type.pow] = function(a, b) return math.pow(a, b) end,
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

return {
    evaluation = _evaluation_,
}