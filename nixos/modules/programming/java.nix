{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    gradle
  ];

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };

  home.file = {
    ".jdks/jdk".source = pkgs.jdk21;
    ".jdks/jdk11".source = pkgs.jdk11;
    ".jdks/jdk17".source = pkgs.jdk17;
    ".jdks/jdk21".source = pkgs.jdk21;
    ".jdks/jdk23".source = pkgs.jdk23;
    ".jdks/jdk24".source = pkgs.jdk24;
    ".jdks/jetbrains-jdk".source = pkgs.jetbrains.jdk;
  };
}
