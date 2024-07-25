{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ryujinx
  ];
}
