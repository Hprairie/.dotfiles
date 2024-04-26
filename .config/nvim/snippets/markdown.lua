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
    -- Greek Letter ZOOM
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("$\\alpha$"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("$\\beta$"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("$\\gamma$"),
	}),
    s({ trig = ";d", snippetType = "autosnippet" }, {
        t("$\\delta$"),
    }),
    s({ trig = ";ep", snippetType = "autosnippet" }, {
        t("$\\epsilon$"),
    }),
    s({ trig = ";et", snippetType = "autosnippet" }, {
        t("$\\eta$"),
    }),
    s({ trig = ";z", snippetType = "autosnippet" }, {
        t("$\\zeta$"),
    }),
    s({ trig = ";t", snippetType = "autosnippet" }, {
        t("$\\theta$"),
    }),
    s({ trig = ";k", snippetType = "autosnippet" }, {
        t("$\\kappa$"),
    }),
    s({ trig = ";l", snippetType = "autosnippet" }, {
        t("$\\lambda$"),
    }),
    s({ trig = ";m", snippetType = "autosnippet" }, {
        t("$\\mu$"),
    }),
    s({ trig = ";n", snippetType = "autosnippet" }, {
        t("$\\nu$"),
    }),
    s({ trig = ";x", snippetType = "autosnippet" }, {
        t("$\\xi$"),
    }),
    s({ trig = ";pi", snippetType = "autosnippet" }, {
        t("$\\pi$"),
    }),
    s({ trig = ";r", snippetType = "autosnippet" }, {
        t("$\\rho$"),
    }),
    s({ trig = ";s", snippetType = "autosnippet" }, {
        t("$\\sigma$"),
    }),
    s({ trig = ";t", snippetType = "autosnippet" }, {
        t("$\\tau$"),
    }),
    s({ trig = ";ph", snippetType = "autosnippet" }, {
        t("$\\phi$"),
    }),
    s({ trig = ";ps", snippetType = "autosnippet" }, {
        t("$\\psi$"),
    }),
    s({ trig = ";c", snippetType = "autosnippet" }, {
        t("$\\chi$"),
    }),
    s({ trig = ";o", snippetType = "autosnippet" }, {
        t("$\\omega$"),
    }),
    -- Other fast math stuff
    s({trig = 'frac', describe = "Mathjax fraction"},
        fmta(
            [[$\frac{<>}{<>}$]],
            {i(1), i(2)}
        )
    ),
    s({trig = 'codeblock', describe = "Create a code block fast"},
        fmta(
            [[
            ```<>
            ```<>
            ]],
            {i(1), i(2)}
        )
    ),
}
