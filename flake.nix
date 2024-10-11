{
  description = "Rifat's NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    stylix.url = "github:danth/stylix";
    sddm-sugar-candy-nix.url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      disko,
      ghostty,
      stylix,
      sddm-sugar-candy-nix,
      ...
    }:
    let
      settings = import (./settings.nix) { };
    in
    {
      nixosConfigurations.lovelace = nixpkgs.lib.nixosSystem {
        system = settings.system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${settings.username} = import ./home;
            # home-manager.backupFileExtension = "old";
            home-manager.extraSpecialArgs = {
              inherit settings;
            };
          }
          {
            nix = {
              settings.experimental-features = [
                "nix-command"
                "flakes"
              ];
            };
          }
          disko.nixosModules.disko
          {
            environment.systemPackages = [
              ghostty.packages.${settings.system}.default
            ];
          }
          stylix.nixosModules.stylix
          sddm-sugar-candy-nix.nixosModules.default
        ];
        specialArgs = {
          inherit settings;
        };
      };
    };
}
# vim:et:sw=2:ts=2:sta:nu
