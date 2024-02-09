-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
	    local theme = colors.theme
	    return {
		    NormalFloat = { bg = "none" },
		    FloatBorder = { bg = "none" },
		    FloatTitle = { bg = "none" },

		    -- Save an hlgroup with dark background and dimmed foreground
		    -- so that you can use it where your still want darker windows.
		    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
		    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

		    -- Popular plugins that open floats will link to NormalFloat by default;
		    -- set their background accordingly if you wish to keep them dark and borderless
		    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	    }
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "kanagawa",
    callback = function()
        if vim.o.background == "light" then
            vim.fn.system("kitty +kitten themes Kanagawa_light")
        elseif vim.o.background == "dark" then
            vim.fn.system("kitty +kitten themes Kanagawa_dragon")
        else
            vim.fn.system("kitty +kitten themes Kanagawa")
        end
    end,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
vim.cmd("set termguicolors")

vim.cmd.highlight('SignColumn guibg=NONE')
vim.cmd.highlight('LineNr guibg=NONE')
vim.cmd.highlight('ColorColumn guibg=NONE')
vim.cmd.highlight('TelescopeBorder guibg=NONE')
