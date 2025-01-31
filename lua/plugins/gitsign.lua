return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require('gitsigns').setup {
			signs = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '│' },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 100,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority = 6,
			update_debounce = 10,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = 'single',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				vim.api.nvim_create_autocmd('CursorHold', {
					buffer = bufnr,
					callback = function()
						-- gitsigns.blame_line({})
						gitsigns.toggle_current_line_blame()
					end,
				})

				-- Actions
				-- map('n', '<leader>hs', gitsigns.stage_hunk)
				-- map('n', '<leader>hr', gitsigns.reset_hunk)
				-- map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
				-- map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
				-- map('n', '<leader>hS', gitsigns.stage_buffer)
				-- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
				-- map('n', '<leader>hR', gitsigns.reset_buffer)
				-- map('n', '<leader>hp', gitsigns.preview_hunk)
				map('n', '<leader>gb', function() gitsigns.blame_line{ } end, { desc = "Git blame" })
				map('n', '<leader>gf', function() gitsigns.blame_line{ full = true } end, { desc = "Git blame full" })
				map('n', '<leader>gt', gitsigns.toggle_current_line_blame, { desc = "Git blame line" })
				map('n', '<leader>gd', gitsigns.diffthis, { desc = "Git diff this" })
				map('n', '<leader>gx', gitsigns.toggle_deleted, { desc = "Toggle delete" })
				-- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end
		}
	end
}
