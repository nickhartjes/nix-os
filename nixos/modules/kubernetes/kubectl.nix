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
    openlens
  ];

  home.file.".config/k9s/config.yml".source = ./source/k9s-config.yml;
  home.file.".config/k9s/skin.yml".source = ./source/k9s-skin.yml;
}
