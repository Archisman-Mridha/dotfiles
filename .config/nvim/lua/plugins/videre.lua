return {
  "Owen-Dechow/videre.nvim",
  cmd = "Videre",
  dependencies = {
    "Owen-Dechow/graph_view_yaml_parser",
    "Owen-Dechow/graph_view_toml_parser",
  },
  init = function()
    -- Workaround for videre.nvim bug: when an optional lang (xml2lua) is
    -- missing, its module returns nil, which Lua's require() converts to
    -- boolean true. langs/init.lua then crashes trying to index true[1].
    -- Pre-registering an empty-but-valid spec skips the lang gracefully.
    package.preload["videre.langs.xml"] = function()
      return { {}, {} }
    end
  end,
  opts = {
    box_style = "sharp",
  },
}
