return {
	{
		"tpope/vim-surround", -- Goat plugin
		config = function()
			vim.cmd([[
            nmap <leader>' mzcs"'`z
            nmap <leader>" mzcs'"`z
        ]])
		end,
	},
	{ "tpope/vim-repeat" },
}
