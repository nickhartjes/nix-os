{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [
    k9s
    krew
    kubecolor
    kubectl
    kubectl-doctor
    kubectx
    kubelogin-oidc
    kubent
    kubernetes-helm
    kubernetes-helmPlugins.helm-unittest

    #openlens
  ];

  #home.file.".config/k9s/config.yaml".source = ./source/k9s-config.yaml;
  #home.file.".config/k9s/skins/one-dark.yaml".source = ./source/skins/one-dark.yaml;
}
