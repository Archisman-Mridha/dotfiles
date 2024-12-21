return {
	"chipsenkbeil/distant.nvim",
	branch = "v0.3",

	config = function()
		require("distant"):setup({
			manager = {
				user = true
			},

			["*"] = {
				launch = {
					default = {
						username = "archi",
						options = "ssh.verbose=true"
					},
				},
			},

			buffer = {
				watch = {
					enabled = false
				},
			},
		})
	end,
}
