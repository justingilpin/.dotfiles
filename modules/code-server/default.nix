{
  imports = [
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  services.vscode-server.enable = true;
}

# Enable service for relevant users:
# systemctl --user enable auto-fix-vscode-server.service
