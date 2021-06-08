--[[

--]]
local syntax_tree = require("syntax_tree.syntax_tree")

local function _calc_(exp)
	local tree = syntax_tree.new()
	return tree.solve(exp)
end

return {
	get = _calc_,
}