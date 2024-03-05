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
	s(
		{ trig = "pytorch:import", describe = "Import Common PyTorch Functions." },
		fmt(
			[[
              import torch
              import torch.nn as nn
              import torch.nn.functional as F
            ]],
			{}
		)
	),
	s(
		{ trig = "pytorch:module", describe = "Create a Module class" },
		fmta(
			[[
            class <>(nn.Module):
                def __init__(self, <>):
                    super(<>, self).__init__()
                    <>

                def forward(self, x):
                    <>
                    return x
            ]],
			{ i(1, "MyModule"), i(2, "args"), rep(1), i(3), i(4) }
		)
	),
	s(
		{ trig = "pytorch:device", describe = "Create the device object." },
		fmta(
			[[
            device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
            ]],
			{}
		)
	),
}
