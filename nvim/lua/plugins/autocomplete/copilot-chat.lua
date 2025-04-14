return {
	"CopilotC-Nvim/CopilotChat.nvim",
	version = "*",
	enabled = false,
	cmd = "CopilotChat",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	opts = function()
		local user = vim.env.USER or "User"
		user = user:sub(1, 1):upper() .. user:sub(2)
		return {
			model = "claude-3.7-sonnet",
			auto_insert_mode = false,
			question_header = (vim.g.have_nerd_font and "  " or " ") .. user .. " ",
			answer_header = vim.g.have_nerd_font and "  Copilot " or " Copilot ",
			-- window = {
			-- 	-- width = 0.4,
			-- 	-- layout = "float",
			-- },
		}
	end,
	keys = {
		{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
		{
			"<leader>aa",
			function()
				return require("CopilotChat").toggle()
			end,
			desc = "Toggle (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ax",
			function()
				return require("CopilotChat").reset()
			end,
			desc = "Clear (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>aq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end,
			desc = "Quick Chat (CopilotChat)",
			mode = { "n", "v" },
		},
		-- Show prompts actions with telescope
		-- { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
	},
	config = function(_, opts)
		local chat = require("CopilotChat")

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		chat.setup(opts)
	end,
}
