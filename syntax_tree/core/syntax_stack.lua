--[[
	语法栈
--]]

-- 入栈
local function _push_(stack, value)
	table.insert(stack, value)
end

-- 出栈
local function _pop_(stack)
	local tail = #stack
	return table.remove(stack, tail)
end

-- 拾取
-- 不改变栈大小
local function _peek_(stack, index)
	return stack[index]
end

-- 栈大小
local function _count_(stack)
	return #stack
end

-- 清空
local function _clear_(stack)
	for i=#stack, 1, -1 do
		table.remove(stack, i)
	end
end

-- 打印输出
local function _output_(stack)
	for i=1, #stack do
		local token = stack[i]
		print(string.format("%s: \t%s\t%s", i, token.value, token.type))
	end
end

local function _new_()
	local stack = {}
	
	return {
		push 	= function(value) 	_push_(stack, value) 		end,
		pop 	= function() 		return _pop_(stack) 		end,
		peek 	= function(index) 	return _peek_(stack, index) end,
		count 	= function() 		return _count_(stack) 		end,
		clear	= function()		_clear_(stack) 				end,
		output	= function()		_output_(stack)				end,
	}
end

return {
	new = _new_,
}


