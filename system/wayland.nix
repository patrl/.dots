{ config, lib, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  unstable = import <nixos-unstable> { config = { allowUnfree = true;  }; };
in
  {
    nixpkgs.overlays = [ waylandOverlay ];
    programs.sway.enable = true;
    programs.sway.extraSessionCommands = ''
     MOZ_ENABLE_WAYLAND=1
     export SDL_VIDEODRIVER=wayland
    # needs qt5.qtwayland in systemPackages
     export QT_QPA_PLATFORM=wayland
     export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
     export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    programs.sway.extraPackages = with pkgs; [
      cage
      xwayland
      swaybg   # required by sway for controlling desktop wallpaper
      swayidle # used for controlling idle timeouts and triggers (screen locking, etc)
      swaylock # used for locking Wayland sessions
      unstable.waybar        # polybar-alike
      # i3status-rust # simpler bar written in Rust
      gebaar-libinput  # libinput gestures utility
      glpaper          # GL shaders as wallpaper
      grim             # screen image capture
      kanshi           # dynamic display configuration helper
      mako             # notification daemon
      oguri            # animated background utility
      redshift-wayland # patched to work with wayland gamma protocol
      slurp            # screen area selection tool
      # waypipe          # network transparency for Wayland
      wf-recorder      # wayland screenrecorder
      wl-clipboard     # clipboard CLI utilities
      wtype            # xdotool, but for wayland

      # TODO: more steps required to use this?
      xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots

      unstable.j4-dmenu-desktop

      unstable.bemenu
    ];

    services.xserver.displayManager.extraSessionFilePackages = [ pkgs.sway ];
  }
