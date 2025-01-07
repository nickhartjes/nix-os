#
#  Sway Home manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./sway
#               └─ home.nix *
#

{ config, lib, pkgs, ... }:

let
  inherit (config.networking) hostName;
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      systemctl --user import DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };
in
{


  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;                          # Enable sway-session.target to link to graphical-session.target for systemd
    config = rec {                                      # Sway configuration
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      # menu = "${pkgs.rofi}/bin/rofi -show drun";

      startup = [                                       # Run commands on Sway startup
        {command = "${pkgs.autotiling}/bin/autotiling"; always = true;} # Tiling Script                          # Lock on lid close (currently disabled because using laptop as temporary server)
        {command = ''
          ${pkgs.swayidle}/bin/swayidle \
            timeout 120 '${pkgs.swaylock-fancy}/bin/swaylock-fancy' \
            timeout 240 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' \
            before-sleep '${pkgs.swaylock-fancy}/bin/swaylock-fancy'
        ''; always = true;}                            # Auto lock
      ];

      bars = [];                                        # No bar because using Waybar

      fonts = {                                         # Font usedfor window tiles, navbar, ...
        names = [ "Source Code Pro" ];
        size = 10.0;
      };

      gaps = {                                          # Gaps for containters
        inner = 5;
        outer = 5;
      };

      input = {                                         # Input modules: $ man sway-input
        "type:touchpad" = {
          tap = "disabled";
          dwt = "enabled";
          scroll_method = "two_finger";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
        };
      };

      output = {
        "*".bg = "~/.config/wall fill";#
        "*".scale = "1";#
        "DP-2".mode = "1920x1080";
        "DP-2".pos = "0 0";
        "HDMI-A-2".mode = "1920x1080";
        "HDMI-A-2".pos = "1920 0";
        "HDMI-A-1".mode = "1280x1024";
        "HDMI-A-1".pos = "3840 0";
      };

      workspaceOutputAssign = lib.mkIf (hostName == "desktop") [
        {output = "HDMI-A-2"; workspace = "2";}
        {output = "DP-2"; workspace = "1";}
        {output = "HDMI-A-1"; workspace = "3";}
        {output = "HDMI-A-2"; workspace = "5";}
        {output = "DP-2"; workspace = "4";}
        {output = "HDMI-A-1"; workspace = "6";}
      ];
      defaultWorkspace = "workspace number 2";

      colors.focused = {
        background = "#999999";
        border = "#999999";
        childBorder = "#999999";
        indicator = "#212121";
        text = "#999999";
      };

      keybindings = {                                   # Hotkeys
        "${modifier}+Ctrl+q" = "exec swaymsg exit";     # Exit Sway
        "${modifier}+Return" = "exec ${terminal}";      # Open terminal
        "${modifier}+d" = "exec ${menu}";           # Open menu
        "${modifier}+Escape" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy"; # Lock Screen

        "${modifier}+Shift+c" = "reload";                     # Reload environment
        "${modifier}+q" = "kill";                       # Kill container
        "${modifier}+f" = "fullscreen toggle";          # Fullscreen

        "${modifier}+${left}" = "focus left";              # Focus container in workspace
        "${modifier}+${right}" = "focus right";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${down}" = "focus down";

        "${modifier}+Shift+${left}" = "move left";         # Move container in workspace
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${down}" = "move down";

        #"Alt+Left" = "workspace prev";                  # Navigate to previous or next workspace if it exists
        #"Alt+Right" = "workspace next";
        "Alt+${left}" = "workspace prev_on_output";         # Navigate to previous or next workspace on output if it exists
        "Alt+${right}" = "workspace next_on_output";

        "${modifier}+1" = "workspace number 1";                 # Open workspace x
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 0";


        "${modifier}+Shift+Ctrl+${left}" = "move container to workspace prev, workspace prev";    # Move container to next available workspace and focus
        "${modifier}+Shift+Ctrl+${right}" = "move container to workspace next, workspace next";

        "${modifier}+Shift+1" = "move container to workspace number 1";     # Move container to specific workspace
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 0";

        "Control+${left}" = "resize shrink width 20px"; # Resize container
        "Control+${right}" = "resize grow width 20px";
        "Control+${up}" = "resize shrink height 20px";
        "Control+${down}" = "resize grow height 20px";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui"; # Screenshots

        "${modifier}+s" = "layout stacking"; # Switch the current container between different layout styles
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";


        "${modifier}+Shift+space" = "floating toggle";# Toggle the current focus between tiling and floating mode
        "${modifier}+space" = "focus mode_toggle"; # Swap focus between the tiling area and the floating area
        "${modifier}+a" = "focus parent"; # Move focus to the parent container


        "${modifier}+Shift+minus" = "move scratchpad"; # Move the currently focused window to the scratchpad
        "${modifier}+minus" = "scratchpad show";  # Show the next scratchpad window or hide the focused scratchpad window.


        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";   #Volume control
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";             #Media control
        "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U  5";      # Display brightness control
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
        #"XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";      # Display brightness control
        #"XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
      };
    };
    extraConfig = ''
      set $opacity 0.8
      for_window [class=".*"] opacity 0.95
      for_window [app_id=".*"] opacity 0.95
      for_window [app_id="pcmanfm"] opacity 0.95, floating enable
      for_window [app_id="Alacritty"] opacity $opacity
      for_window [title="drun"] opacity $opacity
      for_window [class="Emacs"] opacity $opacity
      for_window [app_id="pavucontrol"] floating enable, sticky
      for_window [app_id=".blueman-manager-wrapped"] floating enable
      for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
    '';                                    # $ swaymsg -t get_tree or get_outputs
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS="1";  # Needed for cursor in vm

      # GTK environment
      export GDK_BACKEND="wayland,x11"
      export TDESKTOP_DISABLE_GTK_INTEGRATION=1
      export CLUTTER_BACKEND=wayland
      export BEMENU_BACKEND=wayland

      # Firefox
      export MOZ_ENABLE_WAYLAND=1

      # Qt environment
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

      # SDL environment
      export SDL_VIDEODRIVER=wayland

      # Java environment
      export _JAVA_AWT_WM_NONREPARENTING=1

      # Session
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
      export XDG_CURRENT_SESSION=sway
    '';
  };

   environment.systemPackages = with pkgs; [
      dbus-sway-environment

      swaylock
      swaylock-fancy
      swayidle
      # glib                       # gsettings
      #dracula-theme              # gtk theme
      #gnome3.adwaita-icon-theme  # default gnome cursors
      grim                       # screenshot functionality
      slurp                      # screenshot functionality
      wl-clipboard               # wl-copy and wl-paste for copy/paste from stdin / stdout
      #bemenu                     # wayland clone of dmenu
      #mako                       # notification system developed by swaywm maintainer
      wdisplays
      waybar
      ranger
      pcmanfm

      # Launchers
      #wofi
      fuzzel

  #    nwg-bar                   # Bar logout, reboot shutdown
  #    nwg-menu                  # Windows like start menu
  #    nwg-panel                 # Bars
  #    nwg-drawer                # Application start grid
  #    nwg-launchers

      blueberry
      # https://grimoire.science/working-with-wayland-and-sway/
      i3status-rust

      # For desktop/panel controle
      brightnessctl
      ddcutil
      playerctl
      swaynotificationcenter
      gopsuinfo
      pamixer       # Sound increase

      #autotiling
      mpd

      pango             # Text renderer
      dejavu_fonts      # Font
      

      kanshi
      flameshot

      swaybg

      nmon
      networkmanagerapplet
      glances

      blueman           # Bluetooth manager
      # haskellPackages.network-manager-tui # Network manager
      light                               # Brightness control
      pavucontrol                         # Sound

      selectdefaultapplication

      sway-contrib.grimshot
      sway-contrib.inactive-windows-transparency

      # GTK Themes
      themechanger
      theme-vertex
      pop-gtk-theme
      yaru-theme
      zuki-themes
    ];

    nixpkgs.overlays = [(
        self: super: {
          slack  = super.slack.overrideAttrs (old: {
            installPhase = old.installPhase + ''
              rm $out/bin/slack

              makeWrapper $out/lib/slack/slack $out/bin/slack \
              --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
              --prefix PATH : ${lib.makeBinPath [pkgs.xdg-utils]} \
              --add-flags "--enable-features=WebRTCPipeWireCapturer %U"
            '';
          });
        }
      )];
}
