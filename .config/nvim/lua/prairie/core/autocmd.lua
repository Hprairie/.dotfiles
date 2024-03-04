vim.api.nvim_create_autocmd("BufEnter", {
	command = "setl formatoptions-=cro spelloptions=camel,noplainbuffer",
	group = vim.api.nvim_create_augroup("FemboyPrarie", {}),
})
