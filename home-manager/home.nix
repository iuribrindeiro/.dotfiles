{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./theme.nix
      ./hyprland.nix
      ./waybar.nix
    ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "iuri";
  home.homeDirectory = "/home/iuri";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.whatsapp-for-linux
    pkgs.nodejs_21
    pkgs.cliphist
    pkgs.rofi-wayland
    pkgs.wl-clip-persist
    pkgs.wl-clipboard
  ];
}

