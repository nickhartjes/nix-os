{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [
    awscli2
  ];

#  home.file.".aws/config".source = ./source/config.txt;
#  home.file.".aws/credentials".source = ./source/credentials.txt;
}
