{ config, pkgs, ... }:

{
  home.file.".config/gtk-3.0/gtk.css".text = ''
    /* Frosted GTK look */
    window, .background, .sidebar {
      background-color: rgba(25, 25, 25, 0.55);
      backdrop-filter: blur(20px);
    }

    .header-bar, .titlebar {
      background-color: rgba(25, 25, 25, 0.6);
      backdrop-filter: blur(18px);
      border: none;
    }

    *:not(window):not(popover) {
      background-clip: padding-box;
    }
  '';

  home.file.".config/gtk-4.0/gtk.css".text = ''
    window, .background, .sidebar {
      background-color: rgba(25, 25, 25, 0.55);
      backdrop-filter: blur(20px);
    }

    .header-bar, .titlebar {
      background-color: rgba(25, 25, 25, 0.6);
      backdrop-filter: blur(18px);
      border: none;
    }

    *:not(window):not(popover) {
      background-clip: padding-box;
    }
  '';
}

