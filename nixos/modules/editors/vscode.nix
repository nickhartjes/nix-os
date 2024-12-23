#
# VsCode
#

{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs; [
        vscode-extensions.redhat.java
    ];
    };
  };
}

