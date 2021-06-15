# arithmetic_calculator
用Lua实现的基于抽象语法树求四则混合运算的表达式（或公式）的值，目的理解抽象语法树。所以没有加入太多的词法/语法错误的检查，也许以后会加上吧...

Example:

    local engine = require("calc.engine")
    engine.calc("1+2-(4+5)")
    engine.calc("a+b-c", {a=1,b=2,c=3})
