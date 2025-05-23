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

    ghostty.url = "github:ghostty-org/ghostty";
    stylix.url = "github:danth/stylix";
    sddm-sugar-candy-nix.url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      disko,
      ghostty,
      stylix,
      sddm-sugar-candy-nix,
      zen-browser,
      ...
    }:
    let
      settings = import (./settings.nix) { };
      system = settings.system;
      pkgs = import nixpkgs { inherit system; };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      nixosConfigurations.lovelace = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${settings.username} = import ./home;
            home-manager.backupFileExtension = "backup";
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
              ghostty.packages.${system}.default
              zen-browser.packages.${system}.default
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
