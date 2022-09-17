{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    minikube
    argocd
    argocd-autopilot
    kustomize
  ];
}
