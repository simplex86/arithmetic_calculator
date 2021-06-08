--[[

]]
local function _new_(type, value)
    local token = {
        type  = type,
        value = value,
    }

    return token
end

return {
    new = _new_,
}