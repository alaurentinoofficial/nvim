return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup {
			defaults = {
				file_ignore_patterns = {
					"node_modules"
				}
			}
		}
		local builtin = require("telescope.builtin")

		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>p', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
		vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>ht', "<cmd>Telescope colorscheme<CR>", {})
	end
}
