--[[
    词法分析
]]
require("core.const")

-- 创建token
local function _create_token_(type, value)
	local token = {
        type  = type,
        value = value,
    }

    return token
end

-- 扫描表达式，分词构建token列表
local function _solve_(exp)
	local tokens = {}
	
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
				local t = _create_token_(token_type.number, v)
				table.insert(tokens, t)
			end
			
			local type = token_type.operator
			if c == "(" then
				type = token_type.parenthese_left
			elseif c == ")" then
				type = token_type.parenthese_right
			end

			local t = _create_token_(type, c)
			table.insert(tokens, t)

			spt = ept + 1
		end
		
		ept = ept + 1
	end

	if ept > spt then
		local v = string.sub(exp, spt, ept-1)
		local t = _create_token_(token_type.number, v)
		table.insert(tokens, t)
	end
	
	return tokens
end

return {
    solve = _solve_,
}