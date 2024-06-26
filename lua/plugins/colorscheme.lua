return {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		style = "storm",
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	},
	config = function(_, opts)
		local tokyonight = require "tokyonight"
		tokyonight.setup(opts)
		tokyonight.load()
	end,
}
