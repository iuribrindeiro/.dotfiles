{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "catppuccin-macchiato";
  src = pkgs.fetchurl {
    url = "https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-macchiato.zip";
    sha256 = "1yh4f9xdm81bp8qy2yl5nw35haicfczks958zqr5c68kzr6h6hsa";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    mkdir ./temp
    ${pkgs.unzip}/bin/unzip $src -d ./temp
    cp -R ./temp/catppuccin-macchiato/* $out/
    rm $out/metadata.desktop
    echo "
[SddmGreeterTheme]
Name=Catppuccin macchiato
Description=Soothing pastel theme for SDDM
Type=sddm-theme
Version=2.1
Website=https://github.com/catppuccin/sddm
Screenshot=preview.png
MainScript=Main.qml
ConfigFile=theme.conf
TranslationsDirectory=translations
Theme-Id=Catppuccin
Theme-API=2.0
License=MIT
QtVersion=5" > $out/metadata.desktop
  '';

}
