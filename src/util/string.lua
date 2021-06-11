--[[
    扩展string
]]

-- 字符串替换
function string.replace(source, find, replace, wholeword)
    if wholeword then
      find = '%f[%a]' .. find .. '%f[%A]'
    end
    return string.gsub(source, find, replace)
end