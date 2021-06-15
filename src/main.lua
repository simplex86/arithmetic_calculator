--[[

--]]
local engine = require("calc.engine")
local debug = false

local exps = {
	{exp = "1+2+3"},
	{exp = "4-3-2"},
	{exp = "4-(3-2)"},
	{exp = "4-(3-2)*5"},
	{exp = "(6+4)*2+(4-(3-2)*5)/7"},
	{exp = "1+2^3+4"},
	{exp = "(1+2)^3+4"},
	{exp = "a+(b-c)", vars = {a=1, b=2, c=3}},
}

local function _format_(exp, vars, res)
	local text = exp .. "=" .. res
	if vars ~= nil then
		text = text .. " { "
		for k, v in pairs(vars) do
			text = text .. k .. "=" .. v .. " "
		end
		text = text .. "}"
	end

	return text
end

local function main()
	for _, v in pairs(exps) do
		local exp = v.exp
		local vars = v.vars
		print("----------------------------------------------")
		print(exp)
		print("----------------------------------------------")
		local res = engine.calc(exp, vars, debug)

		local text = _format_(exp, vars, res)
		print("calc output: " .. text)
		print("")
	end
end

main()