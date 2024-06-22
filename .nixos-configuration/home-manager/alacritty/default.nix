{users, config, pkgs, ...}: 
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
	dimensions = {
	  lines = 30;
	  columns = 120;
	};
	padding = {
	  x = 0;
	  y = 0;
	};
	opacity = 0.75;
      };
      font = {
	size = 14.0;
      };
      colors = {
	primary = {
	  background = "0x1d1f21";
	  foreground = "0xc5c8c6";
	};
      };
    };
  };
}
