{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    # wayland だと window.decorations = None を指定しても
    # title bar が隠せないので、x11 を指定する
    package = pkgs.alacritty.overrideAttrs (oldAttrs: {
      postInstall = ''
        ${oldAttrs.postInstall or ""}
        wrapProgram $out/bin/alacritty --set WINIT_UNIX_BACKEND x11
      '';
    });
  };

  home.file.".alacritty.toml".source = ./alacritty.toml;
}
