--[[
    字符串扩展
]]

-- 字符串替换
-- wholeword：全词替换
function string.replace(source, find, replace, wholeword)
	if wholeword then
		find = '%f[%a]' .. find .. '%f[%A]'
	end
	return string.gsub(source, find, replace)
end