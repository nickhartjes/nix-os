#
{ pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    k6
    # ( lib.hiPrio playwright )
    # playwright-driver

    #   (runCommand "wrapped-playwright" { buildInputs = [ makeWrapper ]; } ''
    #   mkdir -p "$out/bin"
    #   makeWrapper "${playwright}/bin/playwright" "$out/bin/playwright" \
    #     --set PLAYWRIGHT_BROWSERS_PATH "${playwright-driver.browsers}"
    #   '')
  ];
}
