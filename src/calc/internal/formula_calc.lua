--[[
    公式计算器
]]
require("....util.string")
require("....core.const")
local basec = require("calc.internal.base_calc")

-- 把参数代入公式
local function _formula_(node, vars)
    if node.type == token_type.number then
	    node.value = vars[node.value]
	else
		local L = _formula_(node.lchild, vars)
		local R = _formula_(node.rchild, vars)
	end

	return node
end

-- 获取语法树的值
local function _evaluation_(node, vars)
    _formula_(node, vars)
	local r = basec.evaluation(node)

	return r.value
end

return {
	evaluation = _evaluation_,
}