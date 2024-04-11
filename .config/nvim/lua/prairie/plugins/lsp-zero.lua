return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },

			--{Linting and Formatting}
			{
				"nvimtools/none-ls.nvim",
				dependencies = {
					{ "jay-babu/mason-null-ls.nvim" },
				},
			},

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
				dependencies = {
					{ "saadparwaiz1/cmp_luasnip" },
				},
				config = function()
					require("luasnip").config.set_config({ -- Setting LuaSnip config

						-- Enable autotriggered snippets
						enable_autosnippets = true,

						-- Use Tab (or some other key if you prefer) to trigger visual selection
						store_selection_keys = "<Tab>",

						update_events = "TextChanged,TextChangedI",
					})

					require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
				end,
			},
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end)

			lsp_zero.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = { "python", "lua", "latex" },
				},
			})

			lsp_zero.format_mapping("<leader>mm", {
				format_opts = {
					async = false,
					timeout_ms = 100000,
				},
				servers = {
					["null-ls"] = { "python", "lua", "latex" },
				},
			})

			lsp_zero.setup()

			-- Setup Mason
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer", "pyright", "texlab", "lua_ls" },
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({})
					end,
					--lsp_zero.default_setup,
					lua_ls = function()
						require("neodev").setup()

						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})

			-- Setup Null Ls
			local null_ls = require("null-ls")
			local null_opts = lsp_zero.build_options("null-ls", {})

			null_ls.setup({
				on_attach = function(client, bufnr)
					null_opts.on_attach(client, bufnr)
				end,
				sources = {
					-- You can add tools not supported by mason.nvim
				},
			})
			-- See mason-null-ls.nvim's documentation for more details:
			-- https://github.com/jay-babu/mason-null-ls.nvim#setup
			require("mason-null-ls").setup({
				ensure_installed = { "pylint", "black", "stylua", "latexindent" },
				automatic_installation = true, -- You can still set this to `true`
				automatic_setup = true,
			})

			-- Required when `automatic_setup` is true
			--require("mason-null-ls").setup_handlers()

			-- Setup CMP
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				},
				formatting = lsp_zero.cmp_format(),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = {
					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp_action.tab_complete(),
					["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
					["<A-f>"] = cmp_action.luasnip_jump_forward(),
					["<A-b>"] = cmp_action.luasnip_jump_backward(),
					["<c-b>"] = cmp.mapping.scroll_docs(-4),
					["<c-f>"] = cmp.mapping.scroll_docs(4),
					["<c-n>"] = function()
						if not cmp.visible() then
							cmp.complete()
						end
						cmp.select_next_item()
					end,
					["<c-p>"] = cmp.mapping.select_prev_item(),
					["<c-x>"] = cmp.mapping.abort(),
					["<c-e>"] = function()
						cmp.complete()
						cmp.select_next_item()
						cmp.confirm()
					end,
				}),
			})
		end,
	},
}
