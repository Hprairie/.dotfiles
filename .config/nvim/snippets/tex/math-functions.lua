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

local symbol_snippet = function(context, command, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or command
	context.name = context.name or command:gsub([[\]], "")
	context.docstring = context.docstring or (command .. [[{0}]])
	context.wordTrig = context.wordTrig or false
	j, _ = string.find(command, context.trig)
	if j == 2 then -- command always starts with backslash
		context.trigEngine = "ecma"
		context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
		context.hidden = true
	end
	return autosnippet(context, t(command), opts)
end

SNIPPET_MATH = {
	-- Blocks
	s(
		{
			trig = "al",
			describe = "Creates an equation block",
			snippetType = "autosnippet",
		},
		fmta(
			[[
            \begin{align<>}
                <>
            \end{align<>}
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
		{ trig = "int", name = "integral", dscr = "integral", snippetType = "autosnippet" },
		fmta([[\int<> <>]], { c(1, { t(""), fmta([[_{<>}^{<>}]], { i(1, "-\\infty"), i(2, "\\infty") }) }), i(0) }),
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
		}),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "nnn", name = "bigcap", dscr = "bigcap", snippetType = "autosnippet" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
		fmta([[\bigcap<> <>]], { c(1, { fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	s(
		{ trig = "uuu", name = "bigcup", dscr = "bigcup", snippetType = "autosnippet" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
		fmta([[\bigcup<> <>]], { c(1, { fmta([[_{<>}^{<>}]], { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
		{ condition = is_math, show_condition = is_math }
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
		{ trig = "fp", describe = "Creates a partial derivative fraction snippet", snippetType = "autosnippet" },
		fmta([[\frac{\partial <>}{\partial <>}<>]], { i(1), i(2), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
	-- Additional Functions
	s(
		{ trig = "sq", describe = "Creates a sqrt function", snippetType = "autosnippet" },
		fmta([[\sqrt<><>]], { c(1, { fmta([[{<>}]], { i(1, "") }), fmta([[[<>]{<>}]], { i(1, "2"), i(2) }) }), i(0) }),
		{ condition = is_math, show_condition = is_math }
	),
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
	"quad",
	"to",
	--"in",
}

local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
	table.insert(auto_backslash_snippets, auto_backslash_snippet({ trig = v }, { condition = is_math }))
end
vim.list_extend(SNIPPET_MATH, auto_backslash_snippets)

local symbol_specs = {
	-- operators
	["!="] = { context = { name = "!=" }, command = [[\neq]] },
	["<="] = { context = { name = "≤" }, command = [[\leq]] },
	[">="] = { context = { name = "≥" }, command = [[\geq]] },
	["<<"] = { context = { name = "<<" }, command = [[\ll]] },
	[">>"] = { context = { name = ">>" }, command = [[\gg]] },
	["~~"] = { context = { name = "~" }, command = [[\sim]] },
	["~="] = { context = { name = "≈" }, command = [[\approx]] },
	["~-"] = { context = { name = "≃" }, command = [[\simeq]] },
	["-~"] = { context = { name = "⋍" }, command = [[\backsimeq]] },
	["-="] = { context = { name = "≡" }, command = [[\equiv]] },
	["=~"] = { context = { name = "≅" }, command = [[\cong]] },
	[":="] = { context = { name = "≔" }, command = [[\definedas]] },
	["**"] = { context = { name = "·", priority = 100 }, command = [[\cdot]] },
	xx = { context = { name = "×" }, command = [[\times]] },
	["!+"] = { context = { name = "⊕" }, command = [[\oplus]] },
	["!*"] = { context = { name = "⊗" }, command = [[\otimes]] },
	-- sets
	NN = { context = { name = "ℕ" }, command = [[\mathbb{N}]] },
	ZZ = { context = { name = "ℤ" }, command = [[\mathbb{Z}]] },
	QQ = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
	RR = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
	CC = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
	OO = { context = { name = "∅" }, command = [[\emptyset]] },
	pwr = { context = { name = "P" }, command = [[\powerset]] },
	cc = { context = { name = "⊂" }, command = [[\subset]] },
	cq = { context = { name = "⊆" }, command = [[\subseteq]] },
	qq = { context = { name = "⊃" }, command = [[\supset]] },
	qc = { context = { name = "⊇" }, command = [[\supseteq]] },
	["\\\\\\"] = { context = { name = "⧵" }, command = [[\setminus]] },
	Nn = { context = { name = "∩" }, command = [[\cap]] },
	UU = { context = { name = "∪" }, command = [[\cup]] },
	["::"] = { context = { name = ":" }, command = [[\colon]] },
	-- quantifiers and logic stuffs
	AA = { context = { name = "∀" }, command = [[\forall]] },
	EE = { context = { name = "∃" }, command = [[\exists]] },
	inn = { context = { name = "∈" }, command = [[\in]] },
	notin = { context = { name = "∉" }, command = [[\not\in]] },
	["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
	VV = { context = { name = "∨" }, command = [[\lor]] },
	WW = { context = { name = "∧" }, command = [[\land]] },
	["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
	["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
	["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
	iff = { context = { name = "⟺" }, command = [[\iff]] },
	["->"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
	["!>"] = { context = { name = "↦" }, command = [[\mapsto]] },
	["<-"] = { context = { name = "↦", priority = 250 }, command = [[\gets]] },
	-- differentials
	dp = { context = { name = "⇐" }, command = [[\partial]] },
	-- arrows
	["-->"] = { context = { name = "⟶", priority = 500 }, command = [[\longrightarrow]] },
	["<->"] = { context = { name = "↔", priority = 500 }, command = [[\leftrightarrow]] },
	["2>"] = { context = { name = "⇉", priority = 400 }, command = [[\rightrightarrows]] },
	upar = { context = { name = "↑" }, command = [[\uparrow]] },
	dnar = { context = { name = "↓" }, command = [[\downarrow]] },
	-- etc
	ooo = { context = { name = "∞" }, command = [[\infty]] },
	lll = { context = { name = "ℓ" }, command = [[\ell]] },
	dag = { context = { name = "†" }, command = [[\dagger]] },
	["+-"] = { context = { name = "†" }, command = [[\pm]] },
	["-+"] = { context = { name = "†" }, command = [[\mp]] },
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
	table.insert(
		symbol_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = is_math })
	)
end
vim.list_extend(SNIPPET_MATH, symbol_snippets)

return SNIPPET_MATH
