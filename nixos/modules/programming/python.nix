{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    
      python312Full
      python3Packages.pip
      python3Packages.stdenv
       #onnxruntime
      poetry
  ];
}
