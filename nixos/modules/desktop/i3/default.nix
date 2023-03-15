{ config, lib, pkgs, ... }:
{
  programs.dconf.enable = true;

  services = {
     xserver = {
       enable = true;
       desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = true;
            noDesktop = true;
            enableXfwm = false;
          };
       };
       displayManager.defaultSession = "xfce+i3";
       windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
              dmenu #application launcher most people use
              i3status # gives you the default i3 status bar
              i3lock #default i3 screen locker
              i3blocks #if you are planning on using i3blocks over i3status
           ];
       };
     };
  };

  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm
  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [       # Packages installed
    lxappearance
    dex
    xss-lock
    picom

    ulauncher

    arandr
    volumeicon


    rofi
    polybar
    pywal
    calc
    networkmanager_dmenu

    #https://github.com/adi1090x/polybar-themes

  ];

  fonts.fonts = with pkgs; [
      noto-fonts
      material-icons
      fantasque-sans-mono
      noto-fonts
      terminus_font

      iosevka
      siji
      nerdfonts
  ];
}
