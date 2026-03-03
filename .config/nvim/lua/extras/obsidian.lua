local function get_obsidian_vault()
	local obsidian_vault = tostring(vim.fn.expand(vim.fn.getenv("OBSIDIAN_VAULT")))
	-- vim.notify(obsidian_vault, vim.log.levels.INFO, { title = "Obsidian vault path" })

	if obsidian_vault ~= "v:null" then
		return obsidian_vault
	else
		return nil
	end
end

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	event = function()
		local obsidian_vault = get_obsidian_vault()
		if obsidian_vault ~= nil then
			return "BufReadPre " .. obsidian_vault .. "/*.md"
		else
			return "FileType markdown"
		end
	end,
	keys = {
		{ "<leader>ol", "<cmd>ObsidianLinks<cr> ", desc = "Obsidian links" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<cr> ", desc = "Obsidian backlinks" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		picker = {
			name = "mini.pick", -- Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
		},
		workspaces = {
			{
				name = "vault",
				path = function()
					local obsidian_vault = get_obsidian_vault()
					return obsidian_vault
				end,
			},
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
	end,
}
