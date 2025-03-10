#
# VsCode
#

{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = with pkgs; [
        vscode-extensions.redhat.java
    ];
    };
  };
}
