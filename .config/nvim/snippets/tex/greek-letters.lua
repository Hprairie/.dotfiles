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

local function is_math(_, _, value)
	if vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1 then
		return "\\" .. value
	end
	return ("$\\" .. value .. "$")
end

return {
	-- Greek Letter ZOOM (No math mode)
	s({ trig = ";a", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "alpha" } }),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "beta" } }),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "gamma" } }),
	}),
	s({ trig = ";d", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "delta" } }),
	}),
	s({ trig = ";ep", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "epsilon" } }),
	}),
	s({ trig = ";et", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "eta" } }),
	}),
	s({ trig = ";z", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "zeta" } }),
	}),
	s({ trig = ";t", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "theta" } }),
	}),
	s({ trig = ";k", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "kappa" } }),
	}),
	s({ trig = ";l", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "lambda" } }),
	}),
	s({ trig = ";m", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "mu" } }),
	}),
	s({ trig = ";n", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "nu" } }),
	}),
	s({ trig = ";x", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "xi" } }),
	}),
	s({ trig = ";pi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "pi" } }),
	}),
	s({ trig = ";r", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "rho" } }),
	}),
	s({ trig = ";s", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "sigma" } }),
	}),
	s({ trig = ";t", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "tau" } }),
	}),
	s({ trig = ";ph", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "phi" } }),
	}),
	s({ trig = ";ps", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "psi" } }),
	}),
	s({ trig = ";c", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "chi" } }),
	}),
	s({ trig = ";o", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "omega" } }),
	}),
}
