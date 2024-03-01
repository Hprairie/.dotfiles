local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep


return {
    s({trig='snippet:import', describe="Create all of the local functions to create snippets"},
        fmt(
            [[
            local ls = require("luasnip")
            local s = ls.snippet
            local sn = ls.snippet_node
            local t = ls.text_node
            local i = ls.insert_node
            local f = ls.function_node
            local d = ls.dynamic_node
            local fmt = require("luasnip.extras.fmt").fmt
            local fmta = require("luasnip.extras.fmt").fmta
            local rep = require("luasnip.extras").rep
            ]],
            {}
        )
    ),
    s({trig='snippet:new', describe="Baseline template for a new snippet"},
        fmta(
            [[
                s({trig='<>', describe="<>"},
                    fmta(
                        [[<><>,
                        {<>}
                    )
                ),
            ]],
            {i(1), i(2), i(3), f(function() return "]]" end), i(4)}
        )
    ),
}
