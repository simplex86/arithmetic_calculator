--[[
    词法分析
]]
require("core.const")

local _char_2_type_map_ = {
	["+"] = token_type.add,
	["-"] = token_type.sub,
	["*"] = token_type.mul,
	["/"] = token_type.div,
	["^"] = token_type.pow,
	["("] = token_type.parenthese_left,
	[")"] = token_type.parenthese_right,
}

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
	
	local head = 1
	local tail = 1
	local lens = #exp
	
	while tail <= lens do		
		local c = string.sub(exp, tail, tail)
		if c == "+" or
		   c == "-" or
		   c == "*" or
		   c == "/" or
		   c == "^" or
		   c == "(" or
		   c == ")"
		then
			if tail > head then
				local v = string.sub(exp, head, tail-1)
				local t = _create_token_(token_type.number, v)
				table.insert(tokens, t)
			end
			
			local type = _char_2_type_map_[c]
			local token = _create_token_(type, c)
			table.insert(tokens, token)

			head = tail + 1
		end
		
		tail = tail + 1
	end

	if tail > head then
		local v = string.sub(exp, head, tail-1)
		local t = _create_token_(token_type.number, v)
		table.insert(tokens, t)
	end

	table.insert(tokens, _create_token_(token_type.ending, "="))
	
	return tokens
end

local function _print_(tokens)
	print("lexer output:")
	for k, v in pairs(tokens) do
		print(string.format("%s: \t%s\t%s", k, v.value, v.type))
	end
end

return {
    solve = _solve_,
	print = _print_,
}