return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"V13Axel/neotest-pest",
	},
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run Test File",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.run(vim.fn.getcwd() .. "/tests")
			end,
			desc = "Run test suite",
		},
	},
	-- opts = {
	-- 	adapters = {
	-- 		function()
	-- 			require("neotest-pest")({
	-- 				ignore_dirs = { "vendor", "var" },
	-- 				parallel = 16,
	-- 			})
	-- 		end,
	-- 	},
	-- },
	config = function()
		require("neotest").setup({
			log_level = vim.log.levels.DEBUG,
			adapters = {
				require("neotest-pest")({
					ignore_dirs = { "vendor", "var" },
					parallel = 16,
					results_path = function()
						return "/tmp/nvim.ahmed/pest/pest.xml"
					end,
				}),
			},
		})
	end,
}
