return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-s-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-s-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-s-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-s-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-s-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
		lazy = false,
	},
}
