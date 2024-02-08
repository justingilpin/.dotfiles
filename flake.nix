{
  description = "Justin's NixOS configuration and home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

   # neovim-nightly-overlay = {
   #   inputs.nixpkgs.follows = "nixpkgs";
   #   url = "github:nix-community/neovim-nightly-overlay";
   # };
  };
  outputs = inputs@{ nixpkgs, home-manager, ... }: {
   # let
   #   overlays = [
   #     inputs.neovim-nightly-overlay.overlay
   #    # (import ./overlays/weechat.nix)
   #   ];

    nixosConfigurations = {
      # TODO please change the hostname to your own
      fibonacci = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
    #    inherit config overlays;
        modules = [
          ./hosts/thinkpad/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace justin with your own username
            home-manager.users.justin = import ./home/default.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/configuration.nix

	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.justin = import ./hosts/server/home/default.nix;
	  }
        ];
      };
    };

    nixosConfigurations = {
      # TODO please change the hostname to your own
      seykota = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
    #    inherit config overlays;
        modules = [
          ./hosts/desktop/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace justin with your own username
            home-manager.users.justin = import ./home/default.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
