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

    hyprland.url = "github:hyprwm/Hyprland";
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    solarr = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flakes.url = "github:torifat/flakes";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      stylix,
      zen-browser,
      solarr,
      flakes,
      ...
    }@inputs:
    let
      settings = import (./settings.nix) { };
      system = settings.system;
    in
    {
      overlays.default = import ./overlays.nix;
    }
    // (
      let
        pkgs = import nixpkgs {
          system = settings.system;
          overlays = [
            flakes.overlays.default
            self.overlays.default
          ];
          config.allowUnfree = true;
        };
      in
      {
        formatter.${system} = pkgs.nixfmt;
        nixosConfigurations.lovelace = nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = pkgs;
          modules = [
            solarr.nixosModules.default
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${settings.username} = {
                imports = [
                  (import ./home)
                  flakes.homeManagerModules.default
                ];
              };
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit settings inputs;
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
                zen-browser.packages.${system}.default
              ];
            }
            stylix.nixosModules.stylix
          ];
          specialArgs = {
            inherit settings inputs;
          };
        };
      }
    );
}
# vim:et:sw=2:ts=2:sta:nu
