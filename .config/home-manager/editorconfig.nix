{ pkgs, ... }:

{
	editorconfig = {
		enable = true;
		settings = {
			"*" = {
				indent_size = 2;
				indent_style = "tab";
				tab_width = 2;
				insert_final_newline = true;
				max_line_width = 100;
			};
		};
	};
}
