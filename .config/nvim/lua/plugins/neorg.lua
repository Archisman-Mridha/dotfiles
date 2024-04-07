-- For structured note taking, project and task management, time tracking, slideshows, writing
-- typeset documents and much more.
-- The premise is that all of these features are built on top of a single base file format (.norg),
-- which the user only has to learn once to gain access to all of Neorg's functionality.
return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true
  },

  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "v7.0.0",
    config = function( )
      require("neorg").setup { }
    end
  }
}