{pkgs, config, ...}: 
{
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    xkb = {
      variant = "";
      layout = "us";
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
    };
  };
  
  services.displayManager.sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "30";
    XCURSOR_THEME = "Catppuccin-Macchiato-Blue-Cursors";
  };
  
  programs.hyprland.enable = true;

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
}
