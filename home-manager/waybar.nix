{pkgs, ...}: 
{

	wayland.windowManager.sway = {
		enable = true;
	};

	programs.waybar.enable = true;
	programs.waybar.systemd.enable = true;
	programs.waybar.settings = {
		mainBar = {
			position = "top";
			modules-left = [ "hyprland/workspaces" ];
			modules-center = [ "custom/music" ];
			modules-right = [ "backlight" "clock" "tray" "custom/lock" ];

			"hyprland/workspaces" = {
				disable-scroll = true;
				sort-by-name = true;
				format = " {icon} ";
				format-icons = {
					default = "";
				};
			};

			tray = {
				"icon-size" = 21;
				"spacing" = 10;
			};
			"custom/music" = {
				"format" = "  {}";
					"escape" = true;
					"interval" = 5;
					"tooltip" = false;
					"exec" = "playerctl metadata --format='{{ title }}'";
					"on-click" = "playerctl play-pause";
					"max-length" = 50;
			};
			"clock" = {
				"timezone" = "Brasil/Brasilia";
				"tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				"format-alt" = " {:%d/%m/%Y}";
				"format" = " {:%H:%M}";
			};
			"backlight" = {
				"device" = "intel_backlight";
				"format" = "{icon}";
				"format-icons" = ["" "" "" "" "" "" "" "" ""];
			};
		};
	};

	programs.waybar.style = /home/iuri/.config/home-manager/waybar.css;
}
