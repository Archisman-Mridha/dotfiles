{ pkgs, ... }:
{
	services.yabai = {
		enable = true;
		package = pkgs.yabai;
		enableScriptingAddition = true;
    config = {
			top_padding 		= 3;
      bottom_padding 	= 3;
      left_padding 		= 3;
      right_padding 	= 3;
			window_gap 			= 3;

			window_border                = "on";
      window_border_placement      = "inset";
      window_border_width          = 0;
      window_border_radius         = 10;
      active_window_border_topmost = "off";
			active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";

			/*
				You need to have the SIP (System Integrity Protection) disabled.
				REFER : https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection.
			*/
			window_opacity 					= "on";
      window_opacity_duration = "0.0";
			active_window_opacity 	= "0.8";
      normal_window_opacity	  = "0.7";

      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";

      window_placement 	= "second_child";
      window_topmost 		= "on";
      window_shadow 		= "float";

      split_ratio = "0.50";

      auto_balance = "on";

      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";

      layout = "bsp";
    };
	};
}
