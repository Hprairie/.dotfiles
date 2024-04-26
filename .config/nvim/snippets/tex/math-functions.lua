local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local line_begin = require("luasnip.extras.conditions.expand").line_begin

local function is_math()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local auto_backslash_snippet = function(context, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or (context.trig .. "with automatic backslash")
	context.name = context.name or context.trig
	context.docstring = context.docstring or ([[\]] .. context.trig)
	context.trigEngine = "ecma"
	context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
	return autosnippet(
		context,
		fmta(
			[[
            \<><>
            ]],
			{ f(function(_, snip)
				return snip.captures[1]
			end), i(0) }
		),
		opts
	)
end

SNIPPET_MATH = {
	-- Blocks
	s(
		{
			trig = "eq",
			describe = "Creates an equation block",
			snippetType = "autosnippet",
		},
		fmta(
			[[
            \begin{equation<>}
                <>
            \end{equation<>}
            ]],
			{ c(1, { t("*"), t("") }), i(2), rep(1) }
		),
		{ condition = line_begin, show_condition = line_begin }
	),
	-- Series, Limits, and Cups
	s(
		{ trig = "sum", name = "summation", dscr = "summation", snippetType = "autosnippet" },
		fmta([[\sum<> <>]], { c(1, { fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "prod", name = "product", dscr = "product", snippetType = "autosnippet" },
		fmta([[\prod<> <>]], { c(1, { fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "cprod", name = "coproduct", dscr = "coproduct", snippetType = "autosnippet" },
		fmta([[\coprod<> <>]], { c(1, { fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "lim", name = "lim(sup|inf)", dscr = "lim(sup|inf)", snippetType = "autosnippet" },
		fmta([[\lim<><><>]], {
			c(1, { t(""), t("sup"), t("inf") }),
			c(2, { t(""), fmta([[_{<> \to <>}]], { i(1, "n"), i(2, "\\infty") }) }),
			i(0),
		}),
		{ condition = is_math, show_condition = is_math }
	),
	-- Sets and Binomial
	s(
		{ trig = "set", name = "set", dscr = "set", snippetType = "autosnippet" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
		fmta([[\{<>\}<>]], {
			c(1, { r(1, ""), sn(nil, { r(1, ""), t(" \\mid "), i(2) }), sn(nil, { r(1, ""), t(" \\colon "), i(2) }) }),
			i(0),
		})
	),
	s(
		{ trig = "bnc", name = "binomial", dscr = "binomial (nCR)", snippetType = "autosnippet" },
		fmta([[\binom{<>}{<>}<>]], { i(1), i(2), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	-- Fractions
	s(
		{ trig = "ff", describe = "Creates a fraction snippet", snippetType = "autosnippet" },
		fmta([[\frac{<>}{<>}<>]], { i(1), i(2), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "fd", describe = "Creates a derivative fraction snippet", snippetType = "autosnippet" },
		fmta([[\frac{d <>}{d <>}<>]], { i(1), i(2), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "fp", describe = "Creates a derivative fraction snippet", snippetType = "autosnippet" },
		fmta([[\frac{\partial <>}{\partial <>}<>]], { i(1), i(2), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	-- Symbols with auto backslash
}

local auto_backslash_specs = {
	"arcsin",
	"sin",
	"arccos",
	"cos",
	"arctan",
	"tan",
	"cot",
	"csc",
	"sec",
	"log",
	"ln",
	"exp",
	"ast",
	"star",
	"perp",
	"sup",
	"inf",
	"det",
	"max",
	"min",
	"argmax",
	"argmin",
	"deg",
	"angle",
	"cdot",
	"to",
	"in",
}

local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
	table.insert(auto_backslash_snippets, auto_backslash_snippet({ trig = v }, { condition = is_math }))
end
vim.list_extend(SNIPPET_MATH, auto_backslash_snippets)

return SNIPPET_MATH
