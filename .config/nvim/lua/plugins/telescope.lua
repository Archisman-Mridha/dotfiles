return {
	"nvim-telescope/telescope.nvim",
	opts = function()
		return {
			defaults = {
				layout_config = {
					width = function(_, cols, _)
						return math.floor(cols * 1)
					end,
					height = function(_, rows, _)
						return math.floor(rows * 1)
					end,
					horizontal = {
						preview_cutoff = 0
					}
				}
			}
		}
	end,
}
