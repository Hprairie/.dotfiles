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
	s({ trig = "alpha", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "alpha" } }),
	}),
	s({ trig = "beta", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "beta" } }),
	}),
	s({ trig = "gamma", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "gamma" } }),
	}),
	s({ trig = "delta", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "delta" } }),
	}),
	s({ trig = "epsilon", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "epsilon" } }),
	}),
	s({ trig = "eta", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "eta" } }),
	}),
	s({ trig = "zeta", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "zeta" } }),
	}),
	s({ trig = "theta", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "theta" } }),
	}),
	s({ trig = "kappa", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "kappa" } }),
	}),
	s({ trig = "lambda", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "lambda" } }),
	}),
	s({ trig = "mu", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "mu" } }),
	}),
	s({ trig = "nu", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "nu" } }),
	}),
	s({ trig = "xi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "xi" } }),
	}),
	s({ trig = "pi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "pi" } }),
	}),
	s({ trig = "rho", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "rho" } }),
	}),
	s({ trig = "sigma", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "sigma" } }),
	}),
	s({ trig = "tau", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "tau" } }),
	}),
	s({ trig = "phi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "phi" } }),
	}),
	s({ trig = "psi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "psi" } }),
	}),
	s({ trig = "chi", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "chi" } }),
	}),
	s({ trig = "omega", snippetType = "autosnippet" }, {
		f(is_math, {}, { user_args = { "omega" } }),
	}),
}
