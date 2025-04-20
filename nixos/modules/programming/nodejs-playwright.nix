{ config, lib, pkgs, ... }:

let
  # Create a wrapper script to run Playwright commands in a proper Nix shell environment
  playwright-shell = pkgs.writeShellScriptBin "playwright-shell" ''
    #!/usr/bin/env bash
    export PLAYWRIGHT_BROWSERS_PATH="$HOME/.cache/playwright-browsers"
    # Use nix-shell to provide a compatible environment for dynamically linked executables
    exec ${pkgs.nix}/bin/nix-shell -p nodejs_20 nodePackages.playwright \
      ${lib.concatStringsSep " " (with pkgs; [
        "xorg.libX11" "xorg.libXcomposite" "xorg.libXcursor" "xorg.libXdamage" 
        "xorg.libXext" "xorg.libXfixes" "xorg.libXi" "xorg.libXrandr" 
        "xorg.libXrender" "xorg.libXtst" "xorg.libxcb" "libxkbcommon" 
        "libdrm" "mesa" "pango" "cairo" "freetype" "fontconfig" "glib" 
        "gtk3" "gdk-pixbuf" "atk" "nss" "nspr" "alsaLib" "cups" "dbus" 
        "expat" "gperf" "rpcsvc-proto"
      ])} --run "$@"
  '';
in
{
  home.packages = with pkgs; [
    nodejs_20
    nodePackages.playwright
    nodePackages.playwright-test
    playwright-shell # Our custom wrapper
    
    # Browser dependencies (still included for other use cases)
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    libxkbcommon
    libdrm
    mesa
    pango
    cairo
    freetype
    fontconfig
    glib
    gtk3
    gdk-pixbuf
    atk
    nss
    nspr
    alsaLib
    cups
    dbus
    expat
    gperf
    rpcsvc-proto
  ];

  home.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = "$HOME/.cache/playwright-browsers";
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1"; # Skip automatic downloads to manage manually
  };
  
  # Create a script to download Playwright browsers in the right environment
  home.file.".local/bin/setup-playwright" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      echo "Setting up Playwright browsers..."
      export PLAYWRIGHT_BROWSERS_PATH="$HOME/.cache/playwright-browsers"
      mkdir -p "$PLAYWRIGHT_BROWSERS_PATH"
      
      # Use nix-shell to provide a compatible environment for browser installation
      ${pkgs.nix}/bin/nix-shell -p nodejs_20 nodePackages.playwright --run "npx playwright install"
      echo "Playwright browsers installed successfully to $PLAYWRIGHT_BROWSERS_PATH"
    '';
  };
}