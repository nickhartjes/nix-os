#
# Go
#
{ pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    go          # go language
    air         # live reload
    delve       # go debugger
    gdlv        # gui for go debugger

    #templ       # go template generator
    tailwindcss # css framework 
    minify
  ];
}
