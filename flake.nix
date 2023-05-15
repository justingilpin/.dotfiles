{
  description = "Justin's NixOS and home-manager flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager-wsl.url = "github:viperML/home-manager-wsl";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:pta2002/nixvim?rev=bd6f978d51eb95c8633744331546efbd9206d228";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, home-manager-wsl, nix-colors, ...}@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      user = "justin";
    in {
      nixosConfigurations = {
        virtualbox = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs nix-colors; };
          modules = [
            ./system
            ./hosts/virtualbox.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit nix-colors; };
                users.justin = {
                  imports = [
                    ./home
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              };
            }
          ];
        };
#------Lenovo Legion Laptop -------#
        fibonacci = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs nix-colors; };
          modules = [
          #  ./modules/qtile
            ./hosts/lenovo/configuration.nix
            ./overlays
            ./modules/hyprland
          #  ./modules/awesome
          #  nixos-hardware.nixosModules.lenovo-legion-15inch
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit nix-colors; };
                users.justin = {
                  imports = [
                    ./home
                  ];
                };
              };
            }
          ];
        };
      };
      homeConfigurations = {
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit nix-colors; };
          modules = [
            ./home
            ./home/utils/wsl.nix
            inputs.nixvim.homeManagerModules.nixvim
            home-manager-wsl.homeModules.default { wsl.baseDistro = "ubuntu"; }
          ];
        };
      };
     # apps.${system}.default = {
     #   type = "app";
     #   program = "${
     #         pkgs.writeShellScriptBin "my-hugo-serve" ''
     #           mkdir -p docs/themes
     #           ln -s ${inputs.book} docs/themes/book
     #           ${pkgs.emacs28-nox}/bin/emacs --batch -Q --script publish.el
     #           ${pkgs.hugo}/bin/hugo server -D --source docs --theme book
     #         ''
     #       }/bin/my-hugo-serve";
     # };
    };
}
