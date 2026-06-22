-- mason.nvim is a Neovim plugin that allows you to easily manage external editor tooling such as
-- LSP servers, DAP servers, linters, and formatters through a single interface. It runs everywhere
-- Neovim runs (across Linux, macOS, Windows, etc.), with only a small set of external requirements
-- needed.
return {
  "mason-org/mason.nvim",
  opts = {
    -- Socket Firewall is a free tool that blocks malicious packages at install time, giving
    -- developers proactive protection against rising supply chain attacks.
    -- By default, mason.nvim will automatically install and update the Socket Firewall client.
    firewall = {
      enabled = true,
    },

    ui = {
      height = 0.8,
      border = "rounded",
    },
  },
}
