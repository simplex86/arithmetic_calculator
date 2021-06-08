--[[
	语法树常量
=-]]

-- 节点类型
token_type = {
	none			 = 0, -- 空
	number 	 		 = 1, -- 数字
	operator 		 = 2, -- 操作符
	parenthese_left  = 4, -- 左括号
	parenthese_right = 5, -- 右括号
}