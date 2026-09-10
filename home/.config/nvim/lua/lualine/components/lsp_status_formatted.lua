---@diagnostic disable: undefined-field
local lualine_require = require("lualine_require")
local highlight = require("lualine.highlight")

local function getHighlightFg(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl.fg then
		return string.format("#%06X", hl.fg)
	end
	return nil
end

local function create_status_color_hl(group_name, fg_color, options)
	-- vim.api.nvim_set_hl(0, "MyCustomGroup", { fg = "#FF0000", bg = "#000000", bold = true })
	-- return "MyCustomGroup"
	return highlight.create_component_highlight_group(
		fg_color == "" and {} or { fg = fg_color },
		"lsp_highlight_status_" .. group_name:gsub("%s+", ""),
		options
	)
end

local M = lualine_require.require("lualine.component"):extend()

M.highlights = {}

local default_options = {
	icon = "", -- f013
	symbols = {
		-- Use standard unicode characters for the spinner and done symbols:
		spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
		done = "✓",
		separator = " ",
	},
	-- List of LSP names to ignore (e.g., `null-ls`):
	ignore_lsp = {},
	show_name = true,
	display_names = {},
	colors = {},
}

function M:init(options)
	-- Run `super()`.
	M.super.init(self, options)

	-- Apply default options.
	self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)

	self.colors = vim.tbl_deep_extend("keep", options.colors, {
		pending = getHighlightFg("DiagnosticInfo") or "#569CD6",
		complete = getHighlightFg("DiagnosticOk") or "#4EC9B0",
		clear = getHighlightFg("Normal") or "#000000",
	})

	for name, color in pairs(self.colors) do
		M.highlights[name] = create_status_color_hl(name, color, options)
	end

	-- Apply symbols.
	self.symbols = self.options.symbols or {}

	self.display_names = self.options.display_names or {}

	---The difference between the `begin` and `end` progress events for each LSP.
	---
	---@type table<integer, integer>
	self.lsp_work_by_client_id = {}

	-- Listen to progress updates only if `nvim` supports the `LspProgress` event.
	pcall(vim.api.nvim_create_autocmd, "LspProgress", {
		desc = "Update the Lualine LSP status component with progress",
		group = vim.api.nvim_create_augroup("lualine_lsp_progress", {}),
		---@param event {data: {client_id: integer, params: lsp.ProgressParams}}
		callback = function(event)
			local kind = event.data.params.value.kind
			local client_id = event.data.client_id

			local work = self.lsp_work_by_client_id[client_id] or 0
			local work_change = kind == "begin" and 1 or (kind == "end" and -1 or 0)

			self.lsp_work_by_client_id[client_id] = math.max(work + work_change, 0)

			-- Refresh Lualine to update the LSP status symbol if it changed.
			if (work == 0 and work_change > 0) or (work == 1 and work_change < 0) then
				require("lualine").refresh()
			end
		end,
	})
end

function M:update_status()
	local result = {}
	local processed = {}

	-- Backwards-compatible function to get the active LSP clients.
	---@diagnostic disable-next-line: deprecated
	local get_lsp_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
	local clients = get_lsp_clients({ bufnr = vim.api.nvim_get_current_buf() })
	-- vim.notify(vim.inspect(clients), vim.log.levels.INFO, { title = "LSP Clients" })

	-- Backwards-compatible function to get the current time in nanoseconds.
	local hrtime = (vim.uv or vim.loop).hrtime
	-- Advance the spinner every 80ms only once, not for each client (otherwise the spinners will skip steps).
	-- NOTE: the spinner symbols table is 1-indexed.
	local spinner_symbol = self.symbols.spinner[math.floor(hrtime() / (1e6 * 80)) % #self.symbols.spinner + 1]

	for _, client in ipairs(clients) do
		local status
		local work = self.lsp_work_by_client_id[client.id]
		if work ~= nil and work > 0 then
			status = spinner_symbol
		elseif work ~= nil and work == 0 then
			status = self.symbols.done
		end

		-- Backwards-compatible function to check if a list contains a value.
		local list_contains = vim.list_contains or vim.tbl_contains
		-- Append the status to the LSP only if it supports progress reporting and is not ignored.
		if not processed[client.name] and not list_contains(self.options.ignore_lsp, client.name) then
			local status_display = ((status and status ~= "") and (" " .. status) or "")

			if self.options.show_name then
				local status_clear = highlight.component_format_highlight(M.highlights["clear"])
				local status_color = highlight.component_format_highlight(
					status == self.symbols.done and M.highlights["complete"] or M.highlights["pending"]
				)
				local status_colored = string.format("%s%s%s", status_color, status_display, status_clear)

				local display_name = self.display_names[client.name] or client.name
				if client.config.lualine and client.config.lualine.name then
					display_name = client.config.lualine.name
				end

				if client.config.lualine and client.config.lualine.color and not M.highlights[client.name] then
					M.highlights[client.name] =
						create_status_color_hl(client.name, client.config.lualine.color, self.options)
				end

				if M.highlights[client.name] then
					local client_color = highlight.component_format_highlight(M.highlights[client.name])
					display_name = string.format("%s%s%s", client_color, display_name, status_clear)
				end

				table.insert(result, display_name .. status_colored)
			else
				table.insert(result, status_display)
			end
			processed[client.name] = true
		end
	end

	return table.concat(result, self.symbols.separator)
end

return M
