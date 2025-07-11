local lualine = require("lualine")

-- Color table for highlights.
-- stylua: ignore
local colors = {
  bg       = "#000000",
  fg       = "#bbc2cf",
  yellow   = "#ECBE7B",
  cyan     = "#008080",
  darkblue = "#081633",
  green    = "#98be65",
  orange   = "#FF8800",
  violet   = "#a9a1e1",
  magenta  = "#c678dd",
  blue     = "#89b4fa",
  red      = "#ec5f67",
	white    = "#ffffff",
	grey 		 = "#313244"
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable tabline section and component separators.
		component_separators = "",
		section_separators = "",

		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	tabline = {
		-- These are to remove the defaults.
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_tabline = {
		-- These are to remove the defaults.
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},

	sections = {},
	inactive_sections = {},
}

-- Inserts a component in lualine_c at left section.
local function ins_left(component)
	table.insert(config.tabline.lualine_c, component)
end

-- Inserts a component in lualine_x at right section.
local function ins_right(component)
	table.insert(config.tabline.lualine_x, component)
end

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.bg, bg = colors.blue },
	padding = { left = 1 },
})

ins_left({
	"location",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.bg, bg = colors.blue },
	padding = { left = 1, right = 0 },
})

ins_left({
	function()
		return ""
	end,
	cond = conditions.buffer_not_empty,
	color = { fg = colors.blue, bg = colors.grey },
	padding = {},
})

ins_left({
	"filetype",
	cond = conditions.buffer_not_empty,
	color = { bg = colors.grey, fg = colors.blue },
	padding = { left = 1 },
})

ins_left({
	function()
		return ""
	end,
	cond = conditions.buffer_not_empty,
	color = { fg = colors.grey, bg = colors.black },
	padding = {},
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.cyan },
	},
})

-- Insert mid section.
ins_left({
	function()
		return "%="
	end,
})

ins_left({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.blue, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
	"diff",
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return ""
	end,
	color = { fg = colors.white, bg = colors.black },
	padding = {},
})

ins_right({
	-- Neovim mode component.
	function()
		return ""
	end,
	color = function()
		-- Auto change color according to neovims mode.
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()], bg = colors.white }
	end,
	padding = { left = 1, right = 2 },
})

-- Initialize lualine.
lualine.setup(config)
