{ config, lib, pkgs, ... }:

{
  # Resolve the conflict between KDE Plasma and Seahorse SSH askPassword
  programs.ssh.askPassword = lib.mkForce null;
}