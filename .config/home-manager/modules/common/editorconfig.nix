{
  editorconfig = {
    enable = true;

    /*
      Configuration written to ~/.editorconfig. root = true is automatically added to the file, it
      must not be added here. See https://editorconfig.org for documentation.
    */
    settings = {
      "*" = {
        indent_size = 2;
        indent_style = "space";
        tab_width = 2;
        insert_final_newline = true;
        max_line_width = 100;
      };

      "*.zig" = {
        indent_size = 4;
        tab_width = 4;
      };
    };
  };
}
