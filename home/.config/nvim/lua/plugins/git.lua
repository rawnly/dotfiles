---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		lazy = true,
		keys = {
			-- hunk
			{
				"<leader>gsh",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage Hunk",
			},
			{
				"<leader>grh",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset Hunk",
			},
			{
				mode = "v",
				"<leader>gsh",
				function()
					require("gitsigns").stage_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "Stage Hunk",
			},
			{
				mode = "v",
				"<leader>grh",
				function()
					require("gitsigns").reset_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "Reset Hunk",
			},
			{
				"<leader>gph",
				function()
					require("gitsigns").preview_hunk_inline()
				end,
				desc = "Preview hunk",
			},
			{
				"<leader>gsb",
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "Stage Buffer",
			},
			{
				"<leader>grb",
				function()
					require("gitsigns").reset_buffer()
				end,
				desc = "Reset Buffer",
			},
			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Blame Line",
			},
			{
				"<leader>gB",
				function()
					require("gitsigns").blame()
				end,
				desc = "Toggle Blame",
			},
		},
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			picker = "snacks", -- oppure telescope / fzf-lua / default
		},
		keys = {
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List PRs",
			},
			{
				"<leader>opc",
				"<CMD>Octo pr create<CR>",
				desc = "Create PR",
			},
			{
				"<leader>pc",
				"<CMD>Octo comment add<CR>",
				desc = "PR Comment",
			},
			{
				"<leader>ps",
				"<CMD>Octo comment suggest<CR>",
				desc = "PR Suggestion",
			},

			{
				"<leader>prs",
				"<CMD>Octo review<CR>",
				desc = "Start Review",
			},
			{
				"<leader>prl",
				"<CMD>Octo review list<CR>",
				desc = "List Reviews",
			},
		},
	},
	{
		"emrearmagan/atlas.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional but recommended
			"esmuellert/codediff.nvim", -- optional (PullRequest diff)
			"sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
		},
		-- See Configuration below
		---@type AtlasConfig
		opts = {
			providers = {
				github = {
					hostname = "github.com",
					cache_ttl = 300,
				},
			},
			issues = {
				with_relationships = true, -- Fetch parent/subissue relationships for plain issue tree views.
				custom_actions = {}, -- See :help atlas-custom-actions.
			},
			pulls = {
				---@type AtlasGitHubPullsConfig
				github = {
					---@type AtlasGitHubViewConfig[]
					views = {
						{
							name = "My PRs",
							key = "1",
							layout = "plain", -- "compact", "grouped", or "plain"
							-- current_repo = true, -- Limit this view to the local repository.
							search = "author:@me sort:updated-desc",
						},
						{
							name = "Team",
							key = "2",
							layout = "compact",
							search = "org:your-org sort:updated-desc",
						},
						{
							name = "Repo",
							key = "3",
							layout = "grouped",
							search = "repo:your-org/your-repo",
						},
					},

					bookmarks = {
						key = "S", -- default
						label = "Search", -- default
						items = {
							["Drafts"] = "is:pr is:draft author:@me",
							["Recently merged"] = "is:pr is:merged author:@me sort:updated-desc",
							["Review requested"] = "is:pr is:open review-requested:@me",
						},
					},
				},
			},
		},
	},
}
