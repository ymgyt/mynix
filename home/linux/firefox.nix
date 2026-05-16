{ ... }:
{
  programs.firefox = {
    enable = true;
    # configPath moved to "${config.xdg.configHome}/mozilla/firefox"
    # keep legacy behavior
    configPath = ".mozilla/firefox";
    profiles.ymgyt = {
      extensions.force = true;
      settings = {
        # Enable userChrome.css customization for better theming
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Force dark mode detection
        "ui.systemUsesDarkTheme" = 1;
        # Dark scrollbars
        "widget.content.allow-gtk-dark-theme" = true;
      };
    };
  };
}
