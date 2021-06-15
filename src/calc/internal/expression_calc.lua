--[[
	表达式计算器
--]]
local basec = require("calc.internal.base_calc")

-- 获取语法树的值
local function _evaluation_(node)
	local r = basec.evaluation(node)
	return r.value
end

return {
	evaluation = _evaluation_,
}