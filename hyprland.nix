{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  environment.systemPackages = with pkgs; [
    waybar
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };
}
