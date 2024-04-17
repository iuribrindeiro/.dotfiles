{pkgs, config, ...}: 
{

    services.displayManager = { 
        sddm = {
            enable = true;
# enable experimental support to wayland in sddm
            wayland = {
                enable = true;
            };
            theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
        };
    };

    services.xserver = {
        enable = true;
        videoDrivers = ["nvidia"];
        xkb = {
            variant = "";
            layout = "us";
        };
    };

# fix some buggy things for hyprland to work properly
    environment.variables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
# Use ozone wayland in electron apps, like Chrome
        NIXOS_OZONE_WL = "1";
        XCURSOR_SIZE = "30";
        XCURSOR_THEME = "Catppuccin-Macchiato-Blue-Cursors";
    };

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    programs.waybar.enable = true;
    programs.waybar.package = pkgs.waybar;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    environment.systemPackages = [
        (pkgs.waybar.overrideAttrs (oldAttrs: {
                                    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                                    })
        )
    ];

    fonts.packages = with pkgs; [
        font-awesome
            inter
            (nerdfonts.override { fonts = [ "Meslo" "FantasqueSansMono" ]; })
    ];

# workaround to make login not crash when typing password too fast
# see: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
